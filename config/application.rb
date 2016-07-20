require File.expand_path('../boot', __FILE__)

require 'rails/all'
#require 'Rack/PassbookRack'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)



module Meis
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.assets.paths << Rails.root.join("app","assets","fonts")
    config.middleware.use Rack::PassbookRack
  end
end

module Passbook
  class PassbookNotification

    # This is called whenever a new pass is saved to a users passbook or the
    # notifications are re-enabled.  You will want to persist these values to
    # allow for updates on subsequent calls in the call chain.  You can have
    # multiple push tokens and serial numbers for a specific
    # deviceLibraryIdentifier.

    def self.register_pass(options)
        puts "FUCK!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      the_passes_serial_number = options['serialNumber']
      the_devices_device_library_identifier = options['deviceLibraryIdentifier']
      the_devices_push_token = options['pushToken']
      the_pass_type_identifier = options["passTypeIdentifier"]
      the_authentication_token = options['authToken']

      puts the_passes_serial_number
      puts the_devices_device_library_identifier
      puts the_devices_push_token
      puts the_pass_type_identifier
        # if is unregistered
        if Registration.where(:device_id => the_devices_device_library_identifier, :serial_no => the_passes_serial_number, :passtype_id => the_pass_type_identifier).first == nil
            registration = Registration.new(:device_id => the_devices_device_library_identifier, :serial_no => the_passes_serial_number, :passtype_id => the_pass_type_identifier)
            registration.save
            device = Device.new(:device_id => the_devices_device_library_identifier, :push_token => the_devices_push_token)
            device.save
            {:status => 201}
        else
            # if is registered
            {:status => 200}
        end
      # this is if the pass registered successfully
      # change the code to 200 if the pass has already been registered
      # 404 if pass not found for serialNubmer and passTypeIdentifier
      # 401 if authorization failed
      # or another appropriate code if something went wrong.
    end

    # This is called when the device receives a push notification from apple.
    # You will need to return the serial number of all passes associated with
    # that deviceLibraryIdentifier.

    def self.passes_for_device(options)
      device_library_identifier = options['deviceLibraryIdentifier']
      passes_updated_since = options['passesUpdatedSince']
      puts "DAN"
      puts passes_updated_since
      puts "DAN"

            @now = DateTime.now - 1.day
        ## if this optinal tag was ignored 
            @serials = ''
            registers = Registration.where(:device_id => device_library_identifier).pluck(:serial_no)
        if passes_updated_since == nil
            registers.each do |id|
                @serials += ProfilePass.where(:serial_no => id).pluck(:serial_no).first + ","
            end
            puts @serials
            @serials = @serials.chop
            puts @serials
            puts "ASDASDASDASDASDASDAS"
            text = '{"lastUpdated":"' + @now.to_s + '", "serialNumbers" : ["' + @serials + '"] }'
            puts text

            '{"lastUpdated":"' + @now.to_s + '", "serialNumbers" : ["' + @serials + '"] }'
            #render :json => {"lastUpdated": @now, "serialNumbers": [@serial]}
        else
            registers.each do |id|
                @serials += ProfilePass.where(:serial_no => id && :last_updated < passes_updated_since).pluck(:serial_no).first + ","
            end
            puts @serials
            puts @serials = @serials.chop
            puts @serials
            text = '{"lastUpdated":"' + @now.to_s + '", "serialNumbers" : ["' + @serials + '"] }'
            puts text
            '{"lastUpdated":"' + @now.to_s + '", "serialNumbers" : ["' + @serials + '"] }'

        end

      # the 'lastUpdated' uses integers values to tell passbook if the pass is
      # more recent than the current one.  If you just set it is the same value
      # every time the pass will update and you will get a warning in the log files.
      # you can use the time in milliseconds,  a counter or any other numbering scheme.
      # you then also need to return an array of serial numbers.
    end

    # this is called when a pass is deleted or the user selects the option to disable pass updates.
    def self.unregister_pass(options)
      # a solid unique pair of identifiers to identify the pass are
      puts "FUCK!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      serial_number = options['serialNumber']
      device_library_identifier = options['deviceLibraryIdentifier']
      the_pass_type_identifier = options["passTypeIdentifier"]
      the_authentication_token = options['authToken']

        reg = Registration.where(:device_id => device_library_identifier, :passtype_id => the_pass_type_identifier, :serial_no => serial_number).first
        reg.destroy
        dev = Device.where(:device_id => device_library_identifier).first
        dev.destroy
      # return a status 200 to indicate that the pass was successfully unregistered.
      {:status => 200}
    end

    # this returns your updated pass
    def self.latest_pass(options)
      the_pass_serial_number = options['serialNumber']
      # create your PkPass the way you did when your first created the pass.
      # you will want to return
      my_pass = Passbook::PKPass.new PkPassbuilder.standard_text(the_pass_serial_number)
      # you will want to return the string from the stream of your PkPass object.
      {:status => 200, :latest_pass => mypass.stream.string, :last_modified => '1442120893'}
    end

    # This is called whenever there is something from the update process that is a warning
    # or error
    def self.passbook_log(log)
      # this is a VERY crude logging example.  use the logger of your choice here.
      puts "WE GETTING LOGS"
      #puts log
      # input = ""
      #   long_logs = log[:logs]
      #   long_logs.each do |logg|
      #       input += logg.to_s
      #   end
      #   log2 = Log.new(:log => input)
      #   log2.save
        {:status => 200}
    end
  end
end

