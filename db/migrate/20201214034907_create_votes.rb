class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.references :entry, null: false
      t.references :member, null: false

      t.timestamps
    end
  end
end
