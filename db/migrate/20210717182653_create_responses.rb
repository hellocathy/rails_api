class CreateResponses < ActiveRecord::Migration[6.1]
  def change
    create_table :responses do |t|
      t.references :rating, null: false, index: true
      t.references :question, null: false, index: true
      t.string :answer

      t.timestamps
    end
  end
end
