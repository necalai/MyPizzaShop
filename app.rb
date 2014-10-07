require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:pizzashop.db"

class Product < ActiveRecord::Base
end

before do
	@products = Product.all
end

get '/' do
	erb :index
end

get '/about' do
	erb :about
end

get '/products' do
	erb :products
end

get '/products/:id' do
	@p = Product.find params[:id]
	erb :pizza
end

post '/cart' do
	orders_input = params[:orders]
	@orders = parse_orders_input orders_input
   	erb :cart
end

def parse_orders_input orders_input

	s1 = orders_input.split(/,/)

	arr = []

	s1.each do |x|
		s2 = x.split(/\=/)

		s3 = s2[0].split(/_/)

		id = s3[1]
		cnt = s2[1]

		arr2 = [id, cnt]

		arr.push arr2
	end

	return arr
end
