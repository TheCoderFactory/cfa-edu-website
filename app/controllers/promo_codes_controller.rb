class PromoCodesController < ApplicationController
  before_action :authenticate_admin!
  layout "admin"

  def index
    @promo_codes = PromoCode.all
  end

  def show
    @promo_code = PromoCode.find(params[:id])
  end

  def new
    @promo_code = PromoCode.new
  end

  def create
    @promo_code = PromoCode.new(promo_code_params)
    if @promo_code.save
      redirect_to @promo_code
    else
      respond_with @promo_code
    end
  end

  def edit
    @promo_code = PromoCode.find(params[:id])
  end

  def update
    @promo_code = PromoCode.find(params[:id])
    if @promo_code.update_attributes(promo_code_params)
      redirect_to @promo_code
    else
      respond_with @promo_code
    end
  end

  def destroy
    @promo_code = PromoCode.find(params[:id])
    @post.destroy
    redirect_to promo_codes_path
  end

  private
  def promo_code_params
    params.require(:promo_code).permit(:code, :percent, :note)
  end
end
