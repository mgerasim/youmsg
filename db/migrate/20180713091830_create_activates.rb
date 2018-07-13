class CreateActivates < ActiveRecord::Migration[5.1]
  def change
    create_table :activates do |t|
      t.integer :code
      t.string :phone
      t.string :status

      t.timestamps
    end
  end
end
