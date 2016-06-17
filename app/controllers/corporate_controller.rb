class CorporateController < ApplicationController
  def index
    @posts = Post.all.reverse_chron_order.first(3)
  end
end
