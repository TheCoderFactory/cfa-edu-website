require 'spec_helper'

describe Post do
  it "has a valid factory" do
    expect(FactoryGirl.build(:post)).to be_valid
  end
  it "is valid with title, lead, content, image, publish, published_date, author_name and author_image" do
    post = Post.new(
      title: "Post Title",
      lead: "Post Lead",
      content: "Post Content",
      image: File.new("#{Rails.root}/spec/support/fixtures/post_opening_image.jpg"),
      publish: true,
      published_date: Date.today,
      author_name: "Pete Argent",
      author_image: File.new("#{Rails.root}/spec/support/fixtures/post_author.jpg"))
    expect(post).to be_valid
  end
  it "is invalid without title" do
    expect(Post.new(title: nil)).to have(1).errors_on(:title)
  end
  it "is invalid without lead" do
    expect(Post.new(lead: nil)).to have(1).errors_on(:lead)
  end
  it "is invalid without content" do
    expect(Post.new(content: nil)).to have(1).errors_on(:content)
  end
  it "is invalid without image" do
    expect(Post.new(image: nil)).to have(1).errors_on(:image)
  end
  it "is invalid without publish" do
    expect(Post.new(publish: nil)).to have(1).errors_on(:publish)
  end
  it "is invalid without published_date" do
    expect(Post.new(published_date: nil)).to have(1).errors_on(:published_date)
  end
  it "checks if a post is published" do
    post = build(:post)
    expect(post.is_published?).to eq true
  end
  it "gets only the current articles in the correct order (newest to oldest)" do
    post1 = create(:post, published_date: Date.yesterday)
    post2 = create(:post)
    create(:post, publish: false)
    create(:post, published_date: Date.tomorrow)
    expect(Post.all.current_articles).to eq [post2, post1]
  end
  it "orders posts in reverse chronological order" do
    post1 = create(:post, published_date: Date.yesterday)
    post2 = create(:post)
    post3 = create(:post, published_date: Date.tomorrow)
    expect(Post.all.reverse_chron_order).to match_array([post3, post2, post1])
  end
  it "gets published posts" do
    post1 = create(:post, published_date: Date.yesterday)
    post2 = create(:post)
    create(:post, publish: false)
    create(:post, published_date: Date.tomorrow)
    expect(Post.all.published?).to match_array([post1, post2])
  end
end
