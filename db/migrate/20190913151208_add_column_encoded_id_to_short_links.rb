class AddColumnEncodedIdToShortLinks < ActiveRecord::Migration[5.2]
  def change
    add_column :short_links, :encoded_id, :string
    add_index :short_links, :encoded_id, unique: true
  end
end
