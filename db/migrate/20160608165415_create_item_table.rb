class CreateItemTable < ActiveRecord::Migration
  def change
    create_table :items do |i|
      i.string :description
      i.integer :price
      i.integer :listed_by_id
    end

  end
end
