class AddSubjectToMybooks < ActiveRecord::Migration[6.1]
  def change
    add_column :mybooks, :subject, :string
  end
end
