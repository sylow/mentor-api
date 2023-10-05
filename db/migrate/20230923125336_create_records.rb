class CreateRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :records do |t|
      t.references :user, null: false, foreign_key: true
      t.date :recorded_on
      t.float :weight

      t.timestamps
    end
  end
end
