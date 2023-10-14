require_relative 'spec_helper'

describe Game do
  let(:publish_date) { Date.new(2010, 1, 1) }
  let(:last_played_at) { Date.new(2010, 1, 1) }
  let(:on_spotify) { true }
  let(:archived) { false }

  subject { Game.new('Title', true, last_played_at, publish_date, archived) }

  describe '#initialize' do
    it 'assigns a random ID' do
      expect(subject.id).to be_a(Integer)
    end

    it 'assigns multiplayer' do
      expect(subject.multiplayer).to eq(true)
    end

    it 'inherits publish_date and archived from Catalogue' do
      expect(subject.publish_date).to eq(publish_date)
      expect(subject.archived).to eq(archived)
    end
  end
end
