require "associative_multi_array/version"
require "associative_multi_array/associative"
require "associative_multi_array/mass_associative"

class AssociativeMultiArray
  def initialize *array_in_arrays, category: nil
    @keys   = Array.new
    @hashes = Array.new
    array_in_arrays.each do |array|
      current_hash = Hash.new
      @hashes << current_hash

      array.each do |object|
        key = if block_given?
          yield(object)
        elsif object.respond_to? :association_key
          object.association_key(category)
        else
          object.to_s
        end
        
        @keys << key

        current_hash[key] = object
      end
    end

    @keys.uniq!
    @keys.sort!
  end

  def each
    return enum_for(:each) unless block_given?

    @keys.each do |key|
      yield @hashes.map{|hash| hash[key]}
    end
  end
end
