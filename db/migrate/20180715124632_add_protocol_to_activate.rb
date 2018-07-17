class AddProtocolToActivate < ActiveRecord::Migration[5.1]
  def change
    add_column :activates, :protocol, :text
  end
end
