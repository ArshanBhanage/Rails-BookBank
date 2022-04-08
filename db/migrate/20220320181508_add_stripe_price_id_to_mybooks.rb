class AddStripePriceIdToMybooks < ActiveRecord::Migration[6.1]
  def change
    add_column :mybooks, :stripe_price_id, :string
  end
end
