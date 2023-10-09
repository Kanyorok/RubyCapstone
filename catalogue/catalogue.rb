class Catalogue
  attr_accessor :id, :genre, :author, :source, :label, :publish_date
  attr_reader :archived

  def initialize(publish_date, archived)
    unless publish_date.is_a?(Date)
      raise ArgumentError,
            "Invalid date parameter: #{publish_date}. publish_date must be a Date object."
    end

    @id = Random.rand(1..10_000)
    @publish_date = publish_date || Date.today
    @archived = archived
    @genre = nil
    @author = nil
    @source = nil
    @label = nil
  end
end
