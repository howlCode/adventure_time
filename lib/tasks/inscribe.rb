module Inscribe
  def inscribe(arcs)
    all_arcs = arcs
    current_arcs = []
    votes = []
    winners = []

    all_arcs.each do |arc|
      if arc.expiry.to_date == DateTime.yesterday.in_time_zone(Time.zone).to_date
        current_arcs.push(arc)
      end
    end

    current_arcs.each do |arc|
      votes.push(arc.get_upvotes.size)
    end

    win = votes.max
  
    current_arcs.each do |arc|
      if arc.get_upvotes.size == win
        winners.push(arc)
      else
        arc.delete
      end
    end

    if winners.length > 1
      winners.each do |w|
        w.delete
      end
    else
      winners.each do |w|
        w.inscribed = true
        w.save
      end
    end

  end
end