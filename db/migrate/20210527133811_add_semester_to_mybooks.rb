class AddSemesterToMybooks < ActiveRecord::Migration[6.1]
  def change
    add_column :mybooks, :semester, :string
  end
end
