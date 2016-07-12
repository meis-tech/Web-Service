class UserMailer < ActionMailer::Base
  
  def send_pass(email, person)
  	@email = email
  	@name = person
  	attachments['file.pkpass'] = File.read("public/pkpass/test.pkpass")
  	mail(to: @email, from: 'chudydaniel1@gmail.com', subject: 'Here is your Certified Prysmic Pass') 	
  end
end
