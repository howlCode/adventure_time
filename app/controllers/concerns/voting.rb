module Voting

  def has_voted?(user, arc)
    if arc.voters.exists?(user.id)
      true
    else
      false
    end
  end


end