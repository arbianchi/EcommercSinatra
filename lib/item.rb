class Item < ActiveRecord::Base

  has_many :purchases, through: :users
belongs_to :listed_by, class_name: "User"

  def count_items
    Item.all.count
  end

  def most_expensive_item
    m = Item.maximum(:price)
    Item.where(price: m).first.description
  end

  def get_item_id
    i = Item.where(description: "Mediocre Copper Bottle").first.id
    return i
   end

  def get_item_price id
    Item.where(id: id).first.price.to_f
  end

end
