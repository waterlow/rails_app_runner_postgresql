class CreateMicroposts < ActiveRecord::Migration[7.0]
  def change
    create_table :microposts do |t|
      t.text :content, null: false
      t.references :user, null: false, foreign_key: true, null: false

      t.timestamps

      t.index [:user_id, :created_at]
    end
  end
end
