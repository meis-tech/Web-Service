class UserMailer < ActionMailer::Base
  
  def send_pass(id,email, person)
  	@email = email
  	@name = person
  	attachments['prysmic.pkpass'] = File.read("public/pkpass/#{id}/prysmic.pkpass")
  	mail(to: @email, from: 'chudydaniel1@gmail.com', subject: 'Here is your Certified Prysmic Pass') 	
  end
end
