class ChangeNumericFieldInCocheDatos < ActiveRecord::Migration[6.1]
  def change
		change_column :coche_datos, :horsepower, :decimal, :precision => 4, :scale => 1, null: false
  end
end
