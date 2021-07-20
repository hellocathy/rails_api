class CreateSampleApiUsers < ActiveRecord::Migration[6.1]
  def change
    ApiUser.create(token: "NXNXRDZUQldtMm9oUDhCNGRWMmxOMkVaMjZ6VTlR")
  end
end
