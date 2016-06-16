class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :lead
      t.text :content
      t.string :image
      t.boolean :publish
      t.date :published_date

      t.timestamps null: false
    end
  end
end
