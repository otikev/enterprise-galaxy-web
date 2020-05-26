# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

BusinessForm.create(name: 'Sole Proprietor')
BusinessForm.create(name: 'Partnership')
BusinessForm.create(name: 'Limited Company')
BusinessForm.create(name: 'Other')

BroadSectorName.create(name: 'Financial Services (Banking, Insurance & Investment)')
BroadSectorName.create(name: 'Manufacturing & Industry')
BroadSectorName.create(name: 'Wholesale and Retail Trade')
BroadSectorName.create(name: 'Telecommunication, Information and Technology')
BroadSectorName.create(name: 'Energy, Mining and Minerals')
BroadSectorName.create(name: 'Tourism, Travel and Tour')
BroadSectorName.create(name: 'Agriculture, Forestry and Fishing')
BroadSectorName.create(name: 'Health and Social Services')
BroadSectorName.create(name: 'Non Governmental Organizations (PBO)')
BroadSectorName.create(name: 'Real Estate, Building and Construction')
BroadSectorName.create(name: 'Hospitality, Accomodation & Food Services')
BroadSectorName.create(name: 'Professional, Consultancy and Management Advisory Services')
BroadSectorName.create(name: 'Transport, Export/Import and Storage Services')
BroadSectorName.create(name: 'Education and Training Services')
BroadSectorName.create(name: 'Public Administration (Government)')
BroadSectorName.create(name: 'Other (Specify)')

Enterprise.create(business_name: "Fizz Inc", contact_email: "fizz_inc@example.com")