atom_feed do |feed|
  feed.title("Coder Factory Academy Blog")
  feed.updated(@blog_feed.first.created_at) if @blog_feed.length > 0

  @blog_feed.each do |post|
    feed.entry(post) do |entry|
      entry.title post.title
      entry.content post.content, type: 'html'
      entry.url post_url(post)
      entry.published post.published_date

      entry.author do |author|
        author.name(post.author_name)
      end
    end
  end
end
