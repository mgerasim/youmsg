class AddVerifycodeToChannels < ActiveRecord::Migration[5.1]
  def change
    add_column :channels, :verifycode, :string
  end
end
