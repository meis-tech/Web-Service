require 'passbook'

Passbook.configure do |passbook|

  # Path to your wwdc cert file
  passbook.wwdc_cert = Rails.root.join('public/certs/WWDC.pem')

  # key
  passbook.p12_key = Rails.root.join('public/certs/passkey.pem')

  # Path to your cert.p12 file
  passbook.p12_certificate = Rails.root.join('public/certs/passcertificate.pem')
  
  # Password for your certificate
  passbook.p12_password = 'daniel123'

  ######## GOING TO NEED THIS FOR PUSH NOTIFICATIONS #########
  ################# READ GROCER GEM ##########################

   #    passbook.notification_gateway = 'gateway.push.apple.com'
   #   passbook.notification_passphrase = 'my_hard_password' (optional)
   #   passbook.notification_cert = 'lib/assets/my_notification_cert.pem'
end
