class AddHashpasswordToChannels < ActiveRecord::Migration[5.1]
  def change
    add_column :channels, :hashpassword, :string
  end
end
