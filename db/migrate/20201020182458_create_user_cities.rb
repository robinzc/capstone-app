class CreateUserCities < ActiveRecord::Migration[6.0]
  def change
    create_table :user_cities do |t|
      t.integer :user_id
      t.integer :city_id
      t.boolean :visited
      t.boolean :lived
      t.boolean :current_living
      t.boolean :current_visiting

      t.timestamps
    end
  end
end
