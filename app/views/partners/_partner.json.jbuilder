json.extract! partner, :id, :url, :name, :image, :order, :active, :created_at, :updated_at
json.url partner_url(partner, format: :json)