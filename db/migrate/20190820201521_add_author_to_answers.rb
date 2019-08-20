class AddAuthorToAnswers < ActiveRecord::Migration[5.2]
  def change
    add_reference :answers, :author, foreign_key: { to_table: :users }, null: false
  end
end
