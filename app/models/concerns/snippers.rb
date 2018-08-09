module Snippers
  def display_username
    self.user.email
  end

  def snipped_body
    self.body.truncate(200, omission: '... ')
  end

  def snipped_title
    self.title.truncate(35, omission: '... ')
  end

  def snipped_body
    self.body.truncate(200, omission: '... ')
  end
end