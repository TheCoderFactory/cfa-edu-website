xml.instruct!
xml.rss :version => '2.0', 'xmlns:atom' => 'http://www.w3.org/2005/Atom' do

  xml.channel do
    xml.title 'Coder Factory Academy Blog'
    xml.description 'The latest articles from Coder Factory Academy'
    xml.link 'https://coderfactoryacademy.edu.au'
    xml.language 'en'
    xml.tag! 'atom:link', :rel => 'self', :type => 'application/rss+xml', :href => 'https://coderfactoryacademy.edu.au/blog'

    for post in @posts
      xml.item do
        xml.title post.title
        xml.pubDate(post.published_date.rfc2822)
        xml.link show_post_url(post)
        xml.guid show_post_url(post)
        xml.description(h(post.content))
        xml.image_url post.image
      end
    end

  end

end
