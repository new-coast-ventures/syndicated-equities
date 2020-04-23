namespace :investments do
  task :remove_duplicates => :environment do
    puts "Removing duplicate investments..."
    Investment.all.each do |investment|
      if investment.deal.nil?
        puts "Removing #{investment.id}"
        investment.destroy
      end
    end
  end
end