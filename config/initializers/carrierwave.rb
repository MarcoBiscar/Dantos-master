CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     Rails.application.secrets.aws_key,                        # required
    aws_secret_access_key: Rails.application.secrets.aws_secret,                        # required
    region:                'us-west-2',                  # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'goomp-dev-staging'                          # required
  config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" } # optional, defaults to {}
end
