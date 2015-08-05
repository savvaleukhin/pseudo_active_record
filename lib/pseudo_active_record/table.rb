module PseudoActiveRecord
  class Table
    require 'pstore'

    def initialize(params)
      self.name        = params.fetch(:name)
      self.db          = PStore.new("../pseudo_db/#{self.name}.pstore")
      self.columns     = {}

      parse_table_info
    end

    attr_reader :columns, :primary_key, :name

    def insert(params)
      check_params(params)

      db.transaction do
        index = db.roots.max || 0
        db[index+1] = params.merge({ id: index+1 })
      end
    end

    def update(params)
      check_params(params)

      db.transaction do
        db.roots.each do |r|
          if db[r].include?(params) && r != 0
            index = db[r][:id]
            db[r] = db[r].merge(params).merge(index)
          end
        end
      end
    end

    def where(params)
      check_params(params)

      raw_data = []
      db.transaction(true) do
        db.roots.each do |r|
          if db[r].include?(params) && r != 0
            raw_data << db[r]
          end
        end
      end
      raw_data
    end

    def all
      raw_data = []
      db.transaction(true) do
        db.roots.each do |r|
          raw_data << db[r] unless r == 0
        end
      end
      raw_data
    end

    def delete(params)
      check_params(params)

      db.transaction do
        db.roots.each do |r|
          if db[r].include?(params) && r != 0
            db.delete(r)
          end
        end
      end
    end

    private

    attr_accessor :db
    attr_writer :primary_key, :name, :columns

    def parse_table_info
      db.transaction(true) do
        self.columns = db[0]
      end
      self.primary_key = :id
    end

    def check_params(params)
      raise ArgumentError unless params.keys.all? { |e| columns.key?(e) }
    end
  end
end
