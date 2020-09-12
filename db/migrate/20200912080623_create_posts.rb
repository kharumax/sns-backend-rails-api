class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.references :user,foreign_key: true ,null: false
      t.string :context,null: false
      t.timestamps
    end
    add_index :posts,[:user_id,:created_at]
  end
end
