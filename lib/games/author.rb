require_relative '../catalogue/catalogue'

class Author
  attr_accessor :id, :first_name, :last_name, :items

  def initialize(first_name, last_name)
    @id = Random.rand(1..10_000)
    @first_name = first_name
    @last_name = last_name
    @items = []
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def add_item(item)
    return unless item.can_be_archived?

    @items << item
    item.set_author(self)
  end
end
