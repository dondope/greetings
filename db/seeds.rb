# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user_emails = ['Juergen.Leger@clear-it.de', 'Sven.Czyperreck@clear-it.de', 'Sybille.Raithel@clear-it.de', 'Daniela.Fehn@clear-it.de']
user_emails.each do |user_email|
	user = User.new
	user.email = user_email
	user.password = "test1234"
	user.password_confirmation = "test1234"
	user.save!
end

admin_emails = ['Admin@clear-it.de']
admin_emails.each do |admin_email|
	user = User.new
	user.email = admin_email
	user.password = "admin@welcome"
	user.password_confirmation = "admin@welcome"
	user.save!
end