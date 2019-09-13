class AddColumnCounterToShortLinks < ActiveRecord::Migration[5.2]
  def change
    add_column :short_links, :counter, :integer, default: 0
  end
end
