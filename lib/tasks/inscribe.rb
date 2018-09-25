module Inscribe
  def inscribe(arcs)
    votes = []
    story_ids = []
    draws = []
    winners = []
    losers = []

    arcs.each do |arc|
      votes.push(arc.get_upvotes.size)
      story_ids.push(arc.story.id)
    end

    winners = arcs.select { |arc| arc.get_upvotes.size == votes.max }
    losers = arcs.select { |arc| arc.get_upvotes.size < votes.max || arc.get_upvotes.size == 0 }


    winners.each do |winner|
      if story_ids.uniq[winner.story.id]
        draws.push(winner)
      else
        winner.inscribed = true
        winner.save
        puts winner
      end
    end

    losers.each do |loser|
      loser.delete
    end

    draws.each do |draw|
      draw.expiry.to_date == DateTime.now.end_of_day.in_time_zone(Time.zone).to_date
      draw.save
    end

  end
end