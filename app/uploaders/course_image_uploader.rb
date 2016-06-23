# encoding: utf-8

class CourseImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
end
