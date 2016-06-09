class CreateUserTable < ActiveRecord::Migration
  def change
    create_table :users do |i|
      i.string :first_name
      i.string :last_name
      i.string :password
    end
  end
end
