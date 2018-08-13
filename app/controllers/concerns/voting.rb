module Voting

  def has_voted?(user, arc)
    if user != arc.voters
      false
    else
      true
    end
  end


end