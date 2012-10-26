# encoding: UTF-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)
puts 'Cleaning database...'
City.delete_all
User.delete_all
Place.delete_all
Event.delete_all
Report.delete_all
Discipline.delete_all

puts 'Populating database with fake data...'

User.create! :email =>'admin@example.com', :nickname => 'super admin', :password=>'123qwe', :password_confirmation=>'123qwe', 
             :confirmed_at => Time.now, :role =>'admin'
User.create! :email =>'user@example.com', :nickname => 'simple user', :password=>'123qwe', :password_confirmation=>'123qwe', 
             :confirmed_at => Time.now, :role =>'user'
User.create! :email =>'stupid@example.com', :nickname => 'stupid user!', :password=>'123qwe', :password_confirmation=>'123qwe', 
             :confirmed_at =>Time.now, :role=>'user'

c1 = City.create! :name => 'Kraków'
c2 = City.create! :name => 'Warszawa'
c3 = City.create! :name => 'Wrocław'

Place.create! :name=>'Park jordana', :address=>'reymonta', :closed=>false, :city_id=>c1.id, :description => 'It\'s good place for sth...'
Place.create! :name=>'Basen agh', :address=>'przy agh', :closed=>true, :city_id=>c1.id, :description => 'Just for swimmenrs'
Place.create! :name=>'sala gimastyczna, szkola nr 12', :address=>'gdzies', :closed=>true, :city_id=>c2.id, :description => 'Just for inhouse activites'

Place.create! :name=>'sala gimastyczna, szkola nr 120 we wroclawiu', :address=>'gdzies', :closed=>true, :city_id=>c3.id
Place.create! :name=>'Politechnika Wroclawska', :address=>'gdzies', :closed=>true, :city_id=>c3.id

Discipline.create! :name=>'Piłka nożna'
Discipline.create! :name=>'Koszykówka'
Discipline.create! :name=>'Jazda na rowerze'
Discipline.create! :name=>'Paintball'
Discipline.create! :name=>'Tenis'

Event.create! :name => "Let's play some football!", :max_users => 10, :place_id => Place.first.id, :owner_id => User.first.id, 
              :event_day=>Time.new+10.days, :duration=>100, :description => 'Some cool event...', :discipline_id => Discipline.first.id
                                                             
Event.create! :name => "Let's play some tenis!", :max_users => 3, :place_id => Place.last.id, :owner_id => User.last.id, 
              :event_day=>Time.new+10.days-10.minute, :duration=>45, :description => 'Hey! Who want to play some tenis? Anyone?', :discipline_id=>Discipline.last.id

Event.create! :name => "Let's play some ball!", :max_users => 5, :place_id => Place.last.id, :owner_id => User.last.id, 
              :event_day=>Time.new+29.days, :duration=>120, :discipline_id=>Discipline.first.id

Event.create! :name => "Let's play some basketball!", :max_users => 5, :place_id => Place.last.id, :owner_id => User.last.id, 
              :event_day=>Time.new+10.days+50.minute, :duration=>120, :discipline_id=>Discipline.find_by_name('Koszykówka')
