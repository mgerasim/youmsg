class AddCountrycodeToChannels < ActiveRecord::Migration[5.1]
  def change
    add_column :channels, :countrycode, :string
  end
end
