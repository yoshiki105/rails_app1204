class CreateEntryImages < ActiveRecord::Migration[6.0]
  def change
    create_table :entry_images do |t|

      t.timestamps
    end
  end
end
