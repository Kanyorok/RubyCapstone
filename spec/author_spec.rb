require_relative 'spec_helper'

describe Author do
  let(:author) { Author.new('John', 'Doe') }
  let(:item) { double('item') }

  describe '#initialize' do
    it 'assigns a random ID' do
      expect(author.id).to be_a(Integer)
    end

    it 'sets the first name' do
      expect(author.first_name).to eq('John')
    end

    it 'sets the last name' do
      expect(author.last_name).to eq('Doe')
    end

    it 'initializes an empty items array' do
      expect(author.items).to be_an(Array)
      expect(author.items).to be_empty
    end
  end
end
