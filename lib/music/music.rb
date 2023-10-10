require_relative '../catalogue/catalogue'
require 'date'

class Music < Catalogue
  attr_reader :id, :on_spotify

  def initialize(publish_date, on_spotify)
    super(publish_date, archived)
    @id = Random.rand(1...100)
    @on_spotify = on_spotify
  end

  def can_be_archived?
    (Date.today.year - @publish_date.year) >= 10 && @on_spotify == true
  end
end
