Recaptcha.configure do |config|
  config.public_key  = Settings.recaptcha.site_key
  config.private_key = Settings.recaptcha.secret_key
end
