require_relative 'spec_helper'

describe Music do
  let(:publish_date) { Date.new(2010, 1, 1) }
  let(:on_spotify) { true }
  let(:archived) { false }

  subject { described_class.new(publish_date, on_spotify, archived) }

  describe '#initialize' do
    it 'assigns a random ID' do
      expect(subject.id).to be_a(Integer)
    end

    it 'assigns on_spotify' do
      expect(subject.on_spotify).to eq(true)
    end

    it 'inherits publish_date and archived from Catalogue' do
      expect(subject.publish_date).to eq(publish_date)
      expect(subject.archived).to eq(archived)
    end
  end

  describe '#can_be_archived?' do
    it 'returns true if on_spotify is true and publish_date is over 10 years ago' do
      expect(subject.can_be_archived?).to eq(true)
    end

    it 'returns false if on_spotify is false' do
      non_spotify_music = described_class.new(publish_date, false, archived)
      expect(non_spotify_music.can_be_archived?).to eq(false)
    end

    it 'returns false if publish_date is not over 10 years ago' do
      recent_publish_date = Date.new(2022, 1, 1)
      recent_music = described_class.new(recent_publish_date, on_spotify, archived)
      expect(recent_music.can_be_archived?).to eq(false)
    end
  end
end
