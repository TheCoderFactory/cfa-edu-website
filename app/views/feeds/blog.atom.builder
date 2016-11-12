atom_feed do |feed|
  feed.title("Coder Factory Academy Blog")
  feed.updated(@posts.first.created_at) if @posts.length > 0

  @posts.each do |post|
    feed.entry(post) do |entry|
      entry.title post.title
      entry.content post.content, type: 'html'
      entry.url show_post_path(post)

      entry.author do |author|
        author.name(post.author_name)
      end
    end
  end
end
