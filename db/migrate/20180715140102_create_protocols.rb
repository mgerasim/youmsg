class CreateProtocols < ActiveRecord::Migration[5.1]
  def change
    create_table :protocols do |t|
      t.text :msg
      t.references :activate, foreign_key: true

      t.timestamps
    end
  end
end
