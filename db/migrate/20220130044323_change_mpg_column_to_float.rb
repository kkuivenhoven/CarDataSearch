class ChangeMpgColumnToFloat < ActiveRecord::Migration[6.1]
  def up
    change_column :coche_datos, :mpg, :float
  end 

  def down
    # Either change the column back, or mark it as irreversible with:
    raise ActiveRecord::IrreversibleMigration
  end 
end
