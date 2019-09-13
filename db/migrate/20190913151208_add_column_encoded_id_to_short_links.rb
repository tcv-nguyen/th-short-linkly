class AddColumnEncodedIdToShortLinks < ActiveRecord::Migration[5.2]
  def change
    add_column :short_links, :encoded_id, :integer
  end
end
