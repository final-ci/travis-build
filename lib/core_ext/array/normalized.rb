module CoreExt
  module Array
    module Normalized
      def normalized_array
        Array(self).map(&method(:normalized_array_arrayify)).flatten.compact
      end

      private

      def normalized_array_arrayify(string_or_array)
        return string_or_array unless string_or_array.respond_to?(:split)
        string_or_array.split(/[\s,]+/).map(&:strip).reject(&:empty?)
      end
    end
  end
end

class Array
  include CoreExt::Array::Normalized
end

class String
  include CoreExt::Array::Normalized
end
