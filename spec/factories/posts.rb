# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    title "Post Title"
    lead "Post Lead"
    content "Post Content"
    image { Rack::Test::UploadedFile.new(File.new("#{Rails.root}/spec/support/fixtures/post_opening_image.jpg")) }
    publish true
    published_date Date.today
    author_name "Pete Argent"
    author_image { File.new("#{Rails.root}/spec/support/fixtures/post_author.jpg") }

    factory :invalid_post do
      title nil
    end
  end
end
