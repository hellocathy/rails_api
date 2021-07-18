class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :text, null: false
      t.string :question_type, null: false
      t.string :placeholder
      t.boolean :required, default: true

      t.timestamps
    end
  end
end
