require_relative '../catalogue/catalogue'

class Game < Catalogue
  attr_accessor :title, :multiplayer, :last_played_at, :id, :author

  def initialize(title, multiplayer, last_played_at, publish_date, archived)
    super(publish_date, archived)
    @title = title
    @multiplayer = multiplayer
    @last_played_at = last_played_at
    @id = Random.rand(1...100)
    @author = nil
  end

  def can_be_archived?
    # Check if the parent's method returns true and last_played_at is older than 2 years
    super && (Time.now - @last_played_at) > 2 * 365 * 24 * 60 * 60
  end
end
