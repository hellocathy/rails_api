class CreateApiUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :api_users do |t|
      t.string :token, null: false

      t.timestamps
    end
  end
end
