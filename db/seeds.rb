# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


['super_admin', 'admin', 'registered', 'api'].each do |role|
  Role.find_or_create_by({name: role})
end

user = User.create! :first_name => 'Dan', :role_id => 1, :email => 'chudydaniel1@gmail.com', :password => 'prysmictest', :password_confirmation => 'prysmictest'

user2 = User.create! :first_name => 'Dan', :role_id => 3, :email => 'chudydaniel2@gmail.com', :password => 'prysmictest', :password_confirmation => 'prysmictest'

user3 = User.create! :first_name => 'Bill', :role_id => 3, :email => 'Bill@gmail.com', :password => 'prysmictest', :password_confirmation => 'prysmictest'

user4 = User.create! :first_name => 'Jane', :role_id => 3, :email => 'Jane@gmail.com', :password => 'prysmictest', :password_confirmation => 'prysmictest'

user5 = User.create! :first_name => 'Liza', :role_id => 3, :email => 'Liza@gmail.com', :password => 'prysmictest', :password_confirmation => 'prysmictest'

user6 = User.create! :first_name => 'Alex', :role_id => 3, :email => 'alexgflohr@gmail.com', :password => 'prysmictest', :password_confirmation => 'prysmictest'

## Environments ##
##Environment.create(company: "Test Co", main_contact_name: "Dan Chudy", main_contact_number: "203-981-0422", type_of_entity: "Construction", address: "313 harper lane", description: "we love to ahve a dandy time", minors?: false)