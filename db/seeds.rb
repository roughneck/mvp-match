# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env.development?
  seller = User.create! email: 'sally.seller@example.com', password: 'sally-seller-123', role: 'seller', username: 'sally-seller'

  Product.create! name: 'Product 1', amount_available: 10, cost: 5, user: seller
  Product.create! name: 'Product 2', amount_available: 10, cost: 10, user: seller
  Product.create! name: 'Product 3', amount_available: 5, cost: 20, user: seller
  Product.create! name: 'Product 4', amount_available: 5, cost: 15, user: seller
  Product.create! name: 'Product 5', amount_available: 5, cost: 10, user: seller

  User.create! email: 'burt.buyer@example.com', password: 'burt-buyer-123', role: 'buyer', deposit: 100, username: 'burt-buyer'
end
