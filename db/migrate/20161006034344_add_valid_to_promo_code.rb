class AddValidToPromoCode < ActiveRecord::Migration
  def change
    add_column :promo_codes, :valid_code, :boolean, default: true
  end
end
