class CreateAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :answers do |t|
      t.text :body
      # t.references :question, null: false, foreign_key: true
      t.references :question,  foreign_key: true
      # Prevent you from adding an answer whose question_id doesn't exsist
      # dependent: :destroy
      # It also stops you to delete a question whose answer are yet not deleted
      t.timestamps
    end
  end
end
