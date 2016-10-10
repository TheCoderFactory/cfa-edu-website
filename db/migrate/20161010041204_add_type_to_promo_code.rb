class AddTypeToPromoCode < ActiveRecord::Migration
  def change
    add_column :promo_codes, :code_type, :string
    add_column :promo_codes, :expiry_date, :date
    add_column :promo_codes, :number_of_uses, :integer
  end
end
