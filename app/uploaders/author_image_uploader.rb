# encoding: utf-8

class AuthorImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
end
