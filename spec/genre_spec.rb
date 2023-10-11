require_relative 'spec_helper'

describe Genre do
  let(:genre_name) { 'Rock' }

  subject { described_class.new(genre_name) }

  describe '#initialize' do
    it 'assigns a random ID' do
      expect(subject.id).to be_a(Integer)
    end

    it 'assigns a name' do
      expect(subject.name).to eq(genre_name)
    end

    it 'initializes an empty items array' do
      expect(subject.items).to be_an(Array)
      expect(subject.items).to be_empty
    end
  end

  describe '#add_item' do
    it 'adds an item to the items array' do
      item = Catalogue.new('2023-01-01', false)
      subject.add_item(item)

      expect(subject.items).to include(item)
    end

    it 'sets the genre attribute of the added item to self' do
      item = Catalogue.new('2023-01-01', false) 
      subject.add_item(item)

      expect(item.genre).to eq(subject)
    end
  end
end
