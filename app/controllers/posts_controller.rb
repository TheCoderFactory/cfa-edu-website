class PostsController < ApplicationController
  # before_action :authenticate_admin! , only: [:index, :new, :create, :edit, :update, :destroy]

  def index
    @posts = Post.all.paginate(page: params[:page], per_page: 10)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post
    else
      respond_with @post
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      redirect_to @post
    else
      repsond_with @post
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def show
    @post = Post.find(params[:id])
  end

  def import
  end

  private
  def post_params
    params.require(:post).permit(:title, :lead, :content, :image, :publish, :published_date)
  end
end
