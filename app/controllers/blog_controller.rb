class BlogController < ApplicationController
  def index
    @posts = Post.all.paginate(page: params[:page], per_page: 10)
  end
end
