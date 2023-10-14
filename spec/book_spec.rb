require_relative 'spec_helper'

describe Book do
  let(:publish_date) { Date.new(2020, 1, 1) }
  let(:archived) { false }
  let(:book) { Book.new('Example Publisher', 'good', publish_date, archived) }

  describe '#initialize' do
    it 'assigns the publisher' do
      expect(book.publisher).to eq('Example Publisher')
    end

    it 'assigns the cover state' do
      expect(book.cover_state).to eq('good')
    end

    it 'inherits publish_date and archived from Catalogue' do
      expect(book.publish_date).to eq(publish_date)
      expect(book.archived).to eq(archived)
    end
  end
end
