class CreateEntryImages < ActiveRecord::Migration[6.0]
  def change
    create_table :entry_images do |t|
      t.references :entry   # 外部キー
      t.string :alt_text, null: false, default: '' # 代替テキスト
      t.integer :position   # 表示位置

      t.timestamps
    end
  end
end
