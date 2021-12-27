class ChangeMpgColumnToDecimal < ActiveRecord::Migration[6.1]
  def up
    change_column :coche_datos, :mpg, :decimal, :precision => 2, :scale => 2, null: false
  end

	def down
    # Either change the column back, or mark it as irreversible with:
    raise ActiveRecord::IrreversibleMigration
	end
end
