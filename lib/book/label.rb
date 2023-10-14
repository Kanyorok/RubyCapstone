class Label
  attr_accessor :title, :color, :id
  attr_reader :items

  def initialize(title, color)
    @id = Random.rand(1..100)
    @title = title
    @color = color
    @items = []
  end

  def add_item(item)
    return unless item.instance_of?(Catalogue)

    items << item
    item.label = self
  end
end
