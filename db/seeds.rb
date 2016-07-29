# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

u1 = User.create(
  email: 'matwilq@gmail.com', first_name: 'Mateusz', last_name: 'Wilczyński',
  password: 'password', password_confirmation: 'password'
)
u2 = User.create(
  email: 'jan@kow.com', first_name: 'Jan', last_name: 'Kowalski',
  password: 'password', password_confirmation: 'password'
)

p1 = Photo.create(
  title: 'Tytuł 1', description: 'Opis1', user_id: u1.id,
  image: File.open("#{Rails.root}/spec/support/ror.png")
)
p2 = Photo.create(
  title: 'Tytuł 2', description: 'Opis2', user_id: u1.id,
  image: File.open("#{Rails.root}/spec/support/ror.png")
)
p3 = Photo.create(
  title: 'Tytuł 3', description: 'Opis3', user_id: u2.id,
  image: File.open("#{Rails.root}/spec/support/ror.png")
)
