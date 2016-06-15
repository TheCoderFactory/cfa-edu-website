class Post < ActiveRecord::Base
  extend FriendlyId
  mount_uploader :image, ImageUploader
  mount_uploader :author_image, ImageUploader
  friendly_id :title, use: :slugged

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      post = Post.create row.to_hash.except!("user_id")
      post.image = row.to_hash["image"]
      post.save
    end
  end
end
