module Inscribe
  def inscribe
    all_arcs = Arc.all
    current_arcs = []
    votes = []

    all_arcs.each do |arc|
      if arc.expiry < Time.now 
        # Date.current.end_of_day.in_time_zone(Time.zone)
        current_arcs.push(arc)
      end
    end

    current_arcs.each do |arc|
      votes.push(arc.get_upvotes.size)
    end

    win = votes.max

    current_arcs.each do |arc|
      if arc.get_upvotes.size == win
        arc.inscribed = true
        arc.save
      else
        arc.delete
      end
    end
  end
end