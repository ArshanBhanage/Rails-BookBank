class AddDescriptionToMybooks < ActiveRecord::Migration[6.1]
  def change
    add_column :mybooks, :description, :string
  end
end
