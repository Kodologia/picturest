CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     Settings.aws.key_id,
    aws_secret_access_key: Settings.aws.secret_key,
    region:                Settings.aws.region
  }
  config.fog_directory  = Settings.aws.bucket_name
end
