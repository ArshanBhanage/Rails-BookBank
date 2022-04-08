class AddStripeMybookIdToMybooks < ActiveRecord::Migration[6.1]
  def change
    add_column :mybooks, :stripe_mybook_id, :string
  end
end
