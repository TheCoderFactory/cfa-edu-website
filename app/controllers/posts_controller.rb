class PostsController < ApplicationController
  respond_to :html
  before_action :authenticate_admin!, only: ["index", "new", "create", "edit", "update", "destroy"]
  before_action :set_post, only: ["show"]
  before_action :show_post?, only: ["show"]
  layout "admin", only: ["index", "new", "create", "edit", "update", "destroy"]

  def index
    @posts = Post.all.reverse_chron_order
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to show_post_path(@post)
    else
      respond_with @post
    end
  end

  def edit
    @post = Post.friendly.find(params[:id])
  end

  def update
    @post = Post.friendly.find(params[:id])
    if @post.update_attributes(post_params)
      redirect_to show_post_path(@post)
    else
      respond_with @post
    end
  end

  def destroy
    @post = Post.friendly.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def import
    Post.import params[:file]
    redirect_to :back
  end

  private
  def post_params
    params.require(:post).permit(:title, :lead, :content, :image, :publish, :published_date, :author_name, :author_image, :slug)
  end

  def set_post
    @post = Post.friendly.find(params[:id])
  end

  def show_post?
    redirect_to root_path unless @post.is_published? || admin_signed_in?
  end
end
