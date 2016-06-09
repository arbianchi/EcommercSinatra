class User < ActiveRecord::Base
 # validates_presence_of :username, :password
  validates_length_of :password, minimum: 4
 # validates_uniqueness_of :username
  has_many :items, through: :purchases
  has_many :purchases

 def make_list title
   lists.create! title: title
 end
end
