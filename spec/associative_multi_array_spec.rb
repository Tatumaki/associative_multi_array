require 'spec_helper'

describe AssociativeMultiArray do
  it 'has a version number' do
    expect(AssociativeMultiArray::VERSION).not_to be nil
  end

  describe '#each' do
    it  do
      a = [1,2,3]
      b = ['2','3','4']
      c = [:'3',:'4',:'5']

      a.extend AssociativeMultiArray::MassAssociative
      b.extend AssociativeMultiArray::MassAssociative
      c.extend AssociativeMultiArray::MassAssociative
      
      out = StringIO.new
      AssociativeMultiArray.new(a,b,c).each do |a,b,c|
        out.puts "#{a || :_} #{b || :_} #{c || :_}"
      end

      expect(out.string).to eq <<-EOE
1 _ _
2 2 _
3 3 3
_ 4 4
_ _ 5
      EOE
    end
  end
end
