# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'Cleaning Database'
Post.destroy_all


puts 'Creating Posts'
10.times do |i|
  Post.create(  title: "Foo Title #{i}", 
                body: "Bar Body Lorem Ipsum #{i}" )
end


puts 'Done.'

