class AddProtocolToChannels < ActiveRecord::Migration[5.1]
  def change
    add_column :channels, :protocol, :text
  end
end
