class AddEmailToMybooks < ActiveRecord::Migration[6.1]
  def change
    add_column :mybooks, :email, :string
  end
end
