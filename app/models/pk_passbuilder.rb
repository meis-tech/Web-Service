class PkPassbuilder
	def self.push_to_apple

	Passbook::PushNotification.send_notification Device.find(22).push_token
	# 	token = Device.find(12).push_token
	# 	pusher = Grocer.pusher(
	# 		certificate: "public/certs/certificate.pem",
	# 		passphrase:  "dan123",                       # optional
	# 		gateway:     "gateway.push.apple.com", # optional; See note below. gateway.sandbox.push.apple.com
	# 		port:        2195,                     # optional
	# 		retries:     3  
	# 		)
 #      notification = Grocer::PassbookNotification.new(device_token: token)
 #      pusher.push(notification)

    #  pusher = Grocer.pusher(
    #     certificate: Rails.root.join('public/certs/certificate.pem'),      # required
    #     passphrase:  "dan123",                       # optional
    #     gateway:     "gateway.push.apple.com", # optional; See note below.
    #     port:        2195,                     # optional
    #     retries:     3                         # optional
    # )
 
    #     notification = Grocer::PassbookNotification.new(device_token: Device.find(13).push_token)
    #     pusher.push(notification)
	end
	def self.make_pass(id)
		### PULL ALL INFO FROM PROFILE, AND VALIDADTE, IF FAILES RETURN FALSE
		profile = Profile.find(id)

		if (PersonalHealthRecord.where(:profile_id => id).first) != nil
			if (ProfilePass.where(:profile_id => id).first) == nil
				pp = ProfilePass.new(:serial_no => id, :profile_id => id, :personal_health_record_id => PersonalHealthRecord.where(:profile_id => id).first.id)
				pp.save
			else
				pp = ProfilePass.where(:serial_no => id).first
				pp.last_modified = DateTime.now
				pp.save
			end
		else
		 	return false		
		end
		text = self.standard_text(id)
		pass = Passbook::PKPass.new text
		pass.addFile Rails.root.join('public/pkpass/pass_images/icon.png')
		pass.addFile Rails.root.join('public/pkpass/pass_images/icon@2x.png')
		pass.addFile Rails.root.join('public/pkpass/pass_images/logo.png')
		pass.addFile Rails.root.join('public/pkpass/pass_images/logo@2x.png')
		pass.addFile Rails.root.join('public/pkpass/pass_images/thumbnail.png')
		pkpass = pass.file

		puts  pkpass.path
	  	directory = "public/pkpass/#{id}"
	  	Dir.mkdir(directory) unless File.exists?(directory)
		FileUtils.cp(pkpass.path, "public/pkpass/#{id}/prysmic.pkpass")
		return true
	end

	private 
		def self.standard_text(serial_no)
			domain = "https://0d48e5df.ngrok.io"
			# domain = "https://prysmic.com/"
			profile = Profile.find(serial_no)
			name = profile.first_name + " " + profile.last_name 
			phr = PersonalHealthRecord.where(:profile_id => profile.id).first

			json = '{"formatVersion":1,"passTypeIdentifier":"pass.com.prysmic.membership","serialNumber":"' + profile.id.to_s + '","teamIdentifier":"3RN24Z6N3S","webServiceURL":"' + domain + '","authenticationToken":"vxwxd7J8AlNNFPS8k0a0FfUFtq0ewzFdc","organizationName":" Prysmic ","description":"Medical Emergency Network","logoText":"","foregroundColor":"rgb(58, 92, 172)","backgroundColor":"rgb(30, 30, 30)","beacons":[{"major":2,"minor":150,"proximityUUID":"2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6","relevantText":"Prysmic Profile has been accessed"}],"generic":{"primaryFields":[{"key":"Name","value":"' + name + '"}],"secondaryFields":[{"key":"subtitle","label":"Birthdate","value":"' + profile.DOB + '"}],"auxiliaryFields":[{"key":"level","label":"Contact","value":"' + profile.emergency_contact + '"},{"key":"favorite","label":"Emergency Number","value":"' + profile.phone_number + '     ","textAlignment":"PKTextAlignmentRight"}],"backFields":[{"label":"Emergency Contact","key":"level","value":"' + profile.emergency_contact + '"},{"numberStyle":"PKNumberStyleSpellOut","label":"Medication","key":"level","value":"' + phr.medication + '"},{"numberStyle":"PKNumberStyleSpellOut","label":"Allergies","key":"level","value":"' + phr.allergies + '"},{"numberStyle":"PKNumberStyleSpellOut","label":"Cronic Disease","key":"level","value":"' + phr.chronic_disease + '"},{"numberStyle":"PKNumberStyleSpellOut","label":"Blood Type","key":"level","value":"' + phr.blood_type + '"},{"numberStyle":"PKNumberStyleSpellOut","label":"Primary Pysician","key":"level","value":"Dr. Goldman                                             404-252-0230"},{"numberStyle":"PKNumberStyleSpellOut","label":"Organ Doner","key":"level","value":"' + phr.organ_donor.to_s + '"},{"numberStyle":"PKNumberStyleSpellOut","label":"DNR","key":"level","value":"no"}]}}'			

			json2 = ' {
  "formatVersion" : 1,
  "passTypeIdentifier" : "pass.com.prysmic.membership",
  "serialNumber" : "' + profile.id.to_s + '",
  "teamIdentifier" : "3RN24Z6N3S",
  "webServiceURL" : "'+ domain + '",
  "authenticationToken" : "vxwxd7J8AlNNFPS8k0a0FfUFtq0ewzFdc",

  "organizationName" : " Prysmic ",
  "description" : "Medical Emergency Network",
  "logoText" : "",
  "foregroundColor" : "rgb(58, 92, 172)",
  "backgroundColor" : "rgb(30, 30, 30)",
  "beacons" : [
  {
    "major" : 2,
    "minor" : 150,
    "proximityUUID" : "2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6",
    "relevantText" : "Prysmic Profile has been accessed"
  }
],
  "generic" : {
    "primaryFields" : [
      {
        "key" : "Name",
        "value" : "' + name + '"
      }
    ],
    "secondaryFields" : [
      {
        "key" : "subtitle",
        "label" : "Birthdate",
        "value" : "' + profile.DOB + '"
      }
    ],
    "auxiliaryFields" : [
      {
        "key" : "level",
        "label" : "Contact",
        "value" : "' + profile.emergency_contact + '"
      },
      {
        "key" : "favorite",
        "label" : "Emergency Number",
        "value" : "' + profile.phone_number + '     ",
        "textAlignment" : "PKTextAlignmentRight"
      }
    ],
    "backFields" : [
      {
        "label" : "Emergency Contact",
        "key" : "level",
        "value" : "' + profile.emergency_contact + '"
      },
      {
        "numberStyle" : "PKNumberStyleSpellOut",
        "label" : "Medication",
        "key" : "level",
        "value" : "' + phr.medication + '"
      },
      {
        "numberStyle" : "PKNumberStyleSpellOut",
        "label" : "Allergies",
        "key" : "level",
        "value" : "' + phr.allergies + '"
      },
      {
        "numberStyle" : "PKNumberStyleSpellOut",
        "label" : "Cronic Disease",
        "key" : "level",
        "value" : "' + phr.chronic_disease + '"
      },
      {
        "numberStyle" : "PKNumberStyleSpellOut",
        "label" : "Blood Type",
        "key" : "level",
        "value" : "' + phr.blood_type + '"
      },
      {
        "numberStyle" : "PKNumberStyleSpellOut",
        "label" : "Primary Pysician",
        "key" : "level", 
        "value" : "Dr. Goldman                                             404-252-0230"
      },
      {
        "numberStyle" : "PKNumberStyleSpellOut",
        "label" : "Organ Doner",
        "key" : "level",
        "value" : "' + phr.organ_donor.to_s + '"
      },
       {
        "numberStyle" : "PKNumberStyleSpellOut",
        "label" : "DNR",
        "key" : "level",
        "value" : "no"
      }
    ]
  }
} '
			return json
		end
end