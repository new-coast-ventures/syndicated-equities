# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'ffaker'

def create_user
  user = User.new
  user.email = FFaker::Internet.email
  user.password = FFaker::Internet.password
  user.first_name = FFaker::Name.first_name
  user.last_name = FFaker::Name.last_name
  user.approved = true
  user.save!
  user.address = create_address(user.id)
  user
end

def create_address(user_id)
  address = Address.new
  address.user_id = user_id
  address.line1 = FFaker::AddressUS.street_address
  address.city = FFaker::AddressUS.city
  address.state = FFaker::AddressUS.state_abbr
  address.zip = FFaker::AddressUS.zip_code
  address.save!
  address
end

def create_deal
  deal = Deal.new
  deal.title = FFaker::Company.name
  deal.description = FFaker::Company.catch_phrase
  deal.date = FFaker::Time.date
  deal.save!
  deal.notes = [create_note(deal.id)]
  deal.forms = [create_form(deal.id)]
  deal
end

def create_note(deal_id)
  note = Note.new
  note.deal_id = deal_id
  note.title = FFaker::Company.catch_phrase
  note.content = FFaker::HTMLIpsum.body
  note.save!
  note
end

def create_form(deal_id)
  form = Form.new
  form.deal_id = deal_id
  form.title = ['Form W-2','Form 1099','Form 1040'].sample
  form.description = FFaker::Company.catch_phrase
  form.save!(validate: false)
  form
end

def create_investment
  user = create_user
  investment = Investment.new
  investment.user_id = user.id
  investment.investor_email = user.email
  investment.deal_id = create_deal.id
  investment.amount_invested = rand(100_000_00)
  investment.invested_on = FFaker::Time.date
  investment.save!
end

20.times do
  create_investment
end

User.create!(email: 'admin@admin.com', first_name: 'admin', last_name: 'admin', password: 'password', admin: true, approved: false)
