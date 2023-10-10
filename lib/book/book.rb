require_relative '../catalogue/catalogue'

class Book < Catalogue
  attr_reader :id

  publisher :publisher
  cover_state :cover_state
  def initialize(publish_date, publisher)
    super(publish_date)
    @id = Random.rand(1...100)
    @publisher = publisher
    @cover_state = cover_state
  end

  def can_be_archived; end
end
