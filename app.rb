# This is a starting point. Feel free to add / modify, as long as the tests pass
require 'sinatra/base'
require 'sinatra/json'
require "./db/setup"
require "./lib/all"
require 'json'

class ShopDBApp < Sinatra::Base
  set :logging, true
  set :show_exceptions, false

  error do |e|
    #binding.pry
    raise e
  end

  before do
    require_authorization!
  end

  def require_authorization!
    unless username
      status 401
      halt({ error: "You must log in"})
    end
  end

  def username
    request.env["HTTP_AUTHORIZATION"]
  end

  post "/users" do
    User.create!(first_name: params[:first_name], last_name: params[:last_name], password: params[:password])
  end

  post "/items" do
    Item.create!(description: params[:description], price: params[:price])
  end

  post "/items/:id/buy" do
    if Item.find(params[:id])
      Purchase.create!(user_id: user.id, item_id: item.id, quantity: params[:quantity])
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  def user
    User.where(password: request.env["HTTP_AUTHORIZATION"]).first
  end

  delete "/items/:id" do
    if (Item.find(params[:id])).listed_by_id == user.id 
      Item.delete_all(params[:id])
      200
    else
      status 403 
    end
  end

  get "/items/:id/purchases" do
    purchasers =  Purchase.where(item_id: params[:id]).pluck(:user_id)
    status 200
    body purchasers.to_json 
  end


  def self.reset_database
    [User, Item, Purchase].each { |klass| klass.delete_all }
  end
end
