class Post < ActiveRecord::Base
  extend FriendlyId
  # mount_uploader :image, ImageUploader
  # mount_uploader :author_image, AuthorImageUploader
  friendly_id :title, use: :slugged

  validates :title, :lead, :content, :image, :published_date, presence: true
  validates_inclusion_of :publish, in: [true, false]

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      post_hash = row.to_hash
      post = Post.find_by(id: post_hash["id"])
      if post
        post.update_attributes(post_hash)
      else
        post = Post.create(post_hash.except!("user_id", "id", "impressions_count"))
        post.image = post_hash["image"]
      end
      post.save
    end
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |post|
        csv << post.attributes.values_at(*column_names)
      end
    end
  end

  def self.current_articles
    published?.reverse_chron_order
  end

  def self.reverse_chron_order
    order(published_date: :desc)
  end

  def self.published?
    current_date = Date.today
    where(publish: true).where("published_date <= ?", current_date)
  end

  def is_published?
    return true if publish && (published_date <= Date.today)
    false
  end
end
