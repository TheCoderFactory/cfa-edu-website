# encoding: utf-8

class TeacherImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
end
