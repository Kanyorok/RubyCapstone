require_relative '../catalogue/catalogue'

class Book < Catalogue
  attr_reader :id
  attr_accessor :publisher, :cover_state
  def initialize(publisher,cover_state,publish_date, archived)
    super(publish_date, archived)
    @id = Random.rand(1...100)
    @publisher = publisher
    @cover_state = cover_state
  end

  def can_be_archived?
    return true if super || @cover_state == 'bad'

    false
  end
end

def to_hash
    item_hash = super
    book_hash = {
     'publisher' => @publisher,
     'cover_state' => @cover_state
    }
item_hash.merge(book_hash)
end