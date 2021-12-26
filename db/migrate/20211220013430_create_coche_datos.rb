class CreateCocheDatos < ActiveRecord::Migration[6.1]
  def change
    create_table :coche_datos do |t|
      t.string :car
      t.float :mpg
      t.integer :cylinders
      t.float :displacement
      t.float :horsepower
      t.float :weight
      t.float :acceleration
      t.integer :model
      t.string :origin

      t.timestamps
    end
  end
end
