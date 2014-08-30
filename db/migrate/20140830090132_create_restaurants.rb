class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :description
      t.string :url
      t.integer :score

      t.timestamps
    end
  end
end
