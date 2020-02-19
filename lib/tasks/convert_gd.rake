require "roo"
require "set"

namespace :convert do
  task :gross_distributions => :environment do
    puts "Updating gds..."
    Investment.all.each do |investment|
      print "*"
      if investment.gross_distribution
        GrossDistribution.create(
          investment_id: investment.id,
          amount: investment.gross_distribution,
          description: "Q4 2019",
          distribution_date: Date.parse(investment.created_at.to_s).strftime("%m/%d/%Y")
        )
      end
    end
  end
end