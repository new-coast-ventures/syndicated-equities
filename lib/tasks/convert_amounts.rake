require "roo"
require "set"

namespace :convert do
  task :amounts => :environment do
    puts "Updating amounts..."
    Investment.find_each do |investment|
      print "*"
      if investment.amount_invested
        amount_invested_cents = investment.amount_invested * 100
      end
      investment.update_attributes(amount_cents: amount_invested_cents)
    end
  end
end