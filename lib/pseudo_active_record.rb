require_relative "pseudo_active_record/version"
require_relative "pseudo_active_record/composable"
require_relative "pseudo_active_record/field_set"
require_relative "pseudo_active_record/table"
require_relative "pseudo_active_record/record"
require_relative "pseudo_active_record/relation"
require_relative "pseudo_active_record/mapping"

module PseudoActiveRecord
  class << self
    def string_to_constant(constant_name)
      constant_name.split("::").inject(Object) { |s,e| s.const_get(e) }
    end
  end
end

class Hash
  def include?(other)
    self.merge(other) == self
  end
end
