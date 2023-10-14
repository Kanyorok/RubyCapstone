require 'date'

class Catalogue
  attr_accessor :id, :genre, :author, :source, :label, :publish_date
  attr_reader :archived

  def initialize(publish_date, archived)
    @id = Random.rand(1..100)
    @publish_date = publish_date || Date.today
    @archived = archived
    @genre = nil
    @author = nil
    @source = nil
    @label = nil
  end

  def can_be_archived?
    (Date.today.year - @publish_date.year) >= 10
  end

  def move_to_archive
    return unless can_be_archived?

    @archived = true
  end
end
