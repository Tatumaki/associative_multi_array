class AssociativeMultiArray
  module MassAssociative
    def self.extended objects
      objects.each do |object|
        begin
          object.singleton_class
          object.extend Associative
        rescue => e
          # nothing to do, use to_s for immediate values.
        end
      end
    end
  end
end
