class PromoCodesController < ApplicationController
  respond_to :html
  before_action :authenticate_admin!, except: ["validate_promo_code"]
  layout "admin"

  def index
    @promo_codes = PromoCode.all.paginate(:page => params[:page], :per_page => 5)
  end

  def new
    @promo_code = PromoCode.new
  end

  def create
    @promo_code = PromoCode.new(promo_code_params)
    if @promo_code.save
      redirect_to promo_codes_path
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
      redirect_to promo_codes_path
    else
      respond_with @promo_code
    end
  end

  def destroy
    @promo_code = PromoCode.find(params[:id])
    @promo_code.destroy
    redirect_to promo_codes_path
  end

  def validate_promo_code
    @promo_code = PromoCode.find_by(code: validation_params[:promocode])
    if @promo_code || validation_params[:promocode].empty?
      @promo_code ? percent = @promo_code.percent : percent = 0
      render json: { success: true, exists: true, percent: percent }
    else
      render json: { success: false, exists: false }
    end
  end

  private
  def promo_code_params
    params.require(:promo_code).permit(:code, :percent, :note)
  end

  def validation_params
    params.permit(:promocode)
  end
end
