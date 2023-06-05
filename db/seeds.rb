# This will delete any existing rows from the Product and User tables
# so you can run the seed file multiple times without having duplicate entries in your database
puts "Deleting old data..."
Product.destroy_all
User.destroy_all

# Reset auto-increment sequence for User table
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name = 'users'")
# Reset auto-increment sequence for Product table
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name = 'products'")


puts "Creating users..."
user1 = User.create(name: Faker::Name.name)
user2 = User.create(name: Faker::Name.name)
user3 = User.create(name: Faker::Name.name)

puts "Creating products..."
product1 = Product.create(name: "Stapler", price: 10)
product2 = Product.create(name: "Whiteboard", price: 15)
product3 = Product.create(name: "Dry Erase Markers", price: 5)
product4 = Product.create(name: "Ballpoint Pens", price: 2)
product5 = Product.create(name: "Scotch Tape", price: 3)

puts "Creating reviews..."

15.times do 
    user_ids = User.all.map {|user| user.id}
    product_ids = Product.all.map {|product| product.id}

    Review.create(
        user_id: user_ids[rand(0..2)],
        product_id: product_ids[rand(0..4)],
        star_rating: rand(1..10),
        comment: Faker::Lorem.sentence(word_count: rand(1...10))
    )
end

puts "Seeding done!"