# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create (
  [
    {username: 'gokhan', name: 'gokhan', email: 'gokhan@example.com', password: '1',
     first_name:'Gokhan', last_name: 'Arli'
    },
  ]
)

gokhan = User.find_by username: 'gokhan'