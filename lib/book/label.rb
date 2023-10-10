require_relative '../catalogue/catalogue'

class Label
  attr_accessor :title, :color, :items
  attr_reader :id

  def initialize(title, color)
    @id = generate_id # You can implement this method to generate a unique ID
    @title = title
    @color = color
    @items = []
  end

  def add_item(item)
    @items << item if item.is_a?(Item)
  end

  private

  def generate_id
    # Implement your logic to generate a unique ID here
  end
end
