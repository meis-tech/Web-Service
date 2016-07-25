require 'passbook'

Passbook.configure do |passbook|

  # Path to your wwdc cert file
  passbook.wwdc_cert = Rails.root.join('public/certs/WWDC.pem')

  # key
  ##passbook.p12_key = Rails.root.join('public/certs/passkey.pem')

  # Path to your cert.p12 file
  passbook.p12_certificate = Rails.root.join('public/certs/Certificates.p12')
  
  # Password for your certificate
  passbook.p12_password = 'dan123'

  ######## GOING TO NEED THIS FOR PUSH NOTIFICATIONS #########
  ################# READ GROCER GEM ##########################
    ##passbook.notification_gateway = 'gateway.sandbox.push.apple.com' ##### DEV #####
    passbook.notification_gateway = 'gateway.push.apple.com'   ##### PROD ######
    passbook.notification_passphrase = 'dan123'
    passbook.notification_cert = Rails.root.join("public/certs/certificate.pem")
end
