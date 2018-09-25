require_relative "inscribe"

namespace :adventuretime do
  include Inscribe
  desc "Determine winning story-arcs for the day"
  task inscribe: :environment do
    puts "Selecting winners..."
    all_arcs = Arc.all.select { |arc| arc.expiry.to_date == DateTime.yesterday.in_time_zone(Time.zone).to_date && arc.inscribed == false }
    # all_arcs = Arc.all.select { |arc| arc.expiry.to_date == DateTime.now.in_time_zone(Time.zone).to_date && arc.inscribed == false }
    inscribe(all_arcs)
  end
end