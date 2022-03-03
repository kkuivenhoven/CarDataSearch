class ChangeMpgFieldInCocheDatos < ActiveRecord::Migration[6.1]
  def change
		change_column :coche_datos, :mpg, :decimal, :precision => 3, :scale => 1, null: false
  end
end
