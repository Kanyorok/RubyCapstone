require_relative 'spec_helper'

describe Label do
  let(:label) { Label.new('Example Label', 'red') }
  let(:item) { Catalogue.new('Item Title', Date.new(2022, 1, 1), false) }

  describe '#initialize' do
    it 'assigns a random ID' do
      expect(label.id).to be_a(Integer)
    end

    it 'sets the title' do
      expect(label.title).to eq('Example Label')
    end

    it 'sets the color' do
      expect(label.color).to eq('red')
    end

    it 'initializes an empty items array' do
      expect(label.items).to be_an(Array)
      expect(label.items).to be_empty
    end
  end
end
