
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
morge = User.create!(name: 'Morge', email: 'example@email.com', password: 'secure_pw', api_key: 'fake_key')
morge.favorites.create!(recipe_link: 'recipe url', recipe_title: 'recipe title', country: 'Benin')
User.create!(name: 'Alan', email: 'ex@email.com', password: 'secure_pw', api_key: 'alans_key')