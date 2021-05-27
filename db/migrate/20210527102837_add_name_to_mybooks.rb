class AddNameToMybooks < ActiveRecord::Migration[6.1]
  def change
    add_column :mybooks, :name, :string
  end
end
