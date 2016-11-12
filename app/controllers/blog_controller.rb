class BlogController < ApplicationController
  def index
    @posts = Post.all.current_articles.paginate(page: params[:page], per_page: 10)
    @blog_feed = Post.current_articles
    respond_to do |format|
        format.html
        format.atom
      end
  end
end
