# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)
puts 'Cleaning database...'
User.delete_all
Place.delete_all

puts 'Populating database with fake data...'

User.create! :email =>'admin@example.com', :password=>'123qwe', :password_confirmation=>'123qwe', :confirmed_at => Time.now, :role =>'admin'
User.create! :email =>'user@example.com', :password=>'123qwe', :password_confirmation=>'123qwe', :confirmed_at => Time.now, :role =>'user'

Place.create! :name=>'Park jordana', :address=>'reymonta', :closed=>false
Place.create! :name=>'Basen agh', :address=>'przy agh', :closed=>true
Place.create! :name=>'sala gimastyczna, szkola nr 12', :address=>'gdzies', :closed=>false

