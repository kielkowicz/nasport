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
Event.delete_all
Report.delete_all

puts 'Populating database with fake data...'

User.create! :email =>'admin@example.com', :nickname => 'super admin', :password=>'123qwe', :password_confirmation=>'123qwe', 
             :confirmed_at => Time.now, :role =>'admin'
User.create! :email =>'user@example.com', :nickname => 'simple user', :password=>'123qwe', :password_confirmation=>'123qwe', 
             :confirmed_at => Time.now, :role =>'user'
User.create! :email =>'stupid@example.com', :nickname => 'stupid user!', :password=>'123qwe', :password_confirmation=>'123qwe', 
             :confirmed_at =>Time.now, :role=>'user'

Place.create! :name=>'Park jordana', :address=>'reymonta', :closed=>false
Place.create! :name=>'Basen agh', :address=>'przy agh', :closed=>true
Place.create! :name=>'sala gimastyczna, szkola nr 12', :address=>'gdzies', :closed=>false

Event.create! :name => "Let's play some football!", :max_users => 10, :place_id => Place.first.id, :owner_id => User.first.id, 
              :event_day=>Time.new+10.days, :duration=>100, :description => 'Some cool event...'
                                                             
Event.create! :name => "Let's play some tenis!", :max_users => 3, :place_id => Place.last.id, :owner_id => User.last.id, 
              :event_day=>Time.new+10.days-10.minute, :duration=>45, :description => 'Hey! Who want to play some tenis? Anyone?'

Event.create! :name => "Let's play some ball!", :max_users => 5, :place_id => Place.last.id, :owner_id => User.last.id, 
              :event_day=>Time.new+33.days, :duration=>120

Event.create! :name => "Let's play some basketball!", :max_users => 5, :place_id => Place.last.id, :owner_id => User.last.id, 
              :event_day=>Time.new+10.days+50.minute, :duration=>120
