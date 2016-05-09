class CreateRegisters < ActiveRecord::Migration
  def change
    create_table :registers do |t|

      t.timestamps null: false
    end
  end
end
