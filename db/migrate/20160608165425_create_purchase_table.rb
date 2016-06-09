class CreatePurchaseTable < ActiveRecord::Migration
  def change
    create_table :purchases do |i|
      i.integer :item_id
      i.integer :user_id
      i.integer :quantity
    end
  end
end
