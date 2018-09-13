module Snippers
  def snipped_title
    self.title.truncate(30, omission: '... ')
  end

  def snipped_body
    self.body.truncate(200, omission: '... ')
  end
end