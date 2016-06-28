Cloudinary.config do |config|
  config.cloud_name = 'coder-factory'
  config.api_key = ENV["CLOUDINARY_API_KEY"]
  config.api_secret = ENV["CLOUDINARY_API_SECRET"]
  config.cdn_subdomain = true
  config.secure = true
end