class Partner < ActiveRecord::Base
  require "csv"
  mount_uploader :image, ImageUploader

  def self.ordered
    order(order: :asc)
  end

  def self.active
    where(active: true)
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|

      partner_hash = row.to_hash # exclude the price field
      partner = Partner.where(name: partner_hash["name"])

      if partner.count == 1
        partner.first.update_attributes(partner_hash)
      else
        Partner.create!(partner_hash)
      end
    end
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << %w{ url name image order active }
      all.each do |partner|
        csv << [partner.url, partner.name, partner.image_url, partner.order, partner.active]
      end
    end
  end

end
