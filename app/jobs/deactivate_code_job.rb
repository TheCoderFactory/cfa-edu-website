class DeactivateCodeJob < ActiveJob::Base
  include SuckerPunch::Job

  def perform(promo_code_id)
    ActiveRecord::Base.connection_pool.with_connection do
      promo_code = PromoCode.find(promo_code_id)
      promo_code.update_attribute(:valid_code, false)
    end
  end
end
