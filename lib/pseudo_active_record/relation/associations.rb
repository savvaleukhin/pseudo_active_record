module PseudoActiveRecord
  class Relation
    class Associations
      def initialize(relation)
        self.relation = relation
      end

      def belongs_to(parent, params)
        relation.define_record_method(parent) do
          PseudoActiveRecord.string_to_constant(params[:class])
                      .find(send(params[:key]))
        end
      end

      def has_many(children, params)
        table_primary_key = relation.table.primary_key

        relation.define_record_method(children) do
          PseudoActiveRecord.string_to_constant(params[:class])
            .where(params[:key] => send(table_primary_key))
        end
      end

      attr_accessor :relation
    end
  end
end
