class ApplicationMailer < ActionMailer::Base
  default from: "noreply@equityfile.com"

  ActionMailer::Base.delivery_method = :smtp 
    ActionMailer::Base.smtp_settings = {
    :address   => "smtp.mandrillapp.com",
    :port      => 587, # ports 587 and 2525 are also supported with STARTTLS
    :enable_starttls_auto => true, # detects and uses STARTTLS
    :user_name => "andrewkeith@me.com",
    :password  => "vIdwddl4dIfZvZiztYkqjQ", # SMTP password is any valid API key
    :authentication => 'login', # Mandrill supports 'plain' or 'login'
    :domain => 'elrok.com', # your domain to identify your server when connecting
    }
end
