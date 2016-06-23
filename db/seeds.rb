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

## Environments ##
##Environment.create(company: "Test Co", main_contact_name: "Dan Chudy", main_contact_number: "203-981-0422", type_of_entity: "Construction", address: "313 harper lane", description: "we love to ahve a dandy time", minors?: false)