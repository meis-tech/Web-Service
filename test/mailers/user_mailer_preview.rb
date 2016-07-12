require 'test_helper'

class UserMailerPreview < ActionMailer::Preview
  def sample_mail_preview
    UserMailer.send_pass('chudydaniel1@gmail.com','hole')
  end
end
