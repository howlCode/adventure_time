require_relative "inscribe"

namespace :adventuretime do
  include Inscribe
  desc "Determine winning story-arcs for the day"
  task inscribe: :environment do
    puts "Selecting winners..."
    puts inscribe(Arc.all)
  end
end