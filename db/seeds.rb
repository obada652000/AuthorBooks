# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

author1 = Author.create!(email: 'author1@example.com', password: 'password', name: 'John Doe')
author2 = Author.create!(email: 'author2@example.com', password: 'password', name: 'Jane Smith')

author1.books.create!(name: 'Book 1 by John Doe', release_date: Date.today)
author1.books.create!(name: 'Book 2 by John Doe', release_date: Date.today)
author2.books.create!(name: 'Book 1 by Jane Smith', release_date: Date.today)
