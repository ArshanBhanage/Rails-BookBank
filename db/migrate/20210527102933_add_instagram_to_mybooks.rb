class AddInstagramToMybooks < ActiveRecord::Migration[6.1]
  def change
    add_column :mybooks, :instagram, :string
  end
end
