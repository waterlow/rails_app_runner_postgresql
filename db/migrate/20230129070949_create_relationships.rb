class CreateRelationships < ActiveRecord::Migration[7.0]
  def change
    create_table :relationships do |t|
      t.bigint :follower_id, null: false
      t.bigint :followed_id, null: false

      t.timestamps

      t.foreign_key :users, column: :follower_id
      t.foreign_key :users, column: :followed_id
      t.index [:follower_id, :followed_id], unique: true
    end
  end
end
