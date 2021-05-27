class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.integer :comments_count
      t.string :email
      t.integer :likes_count
      t.string :password_digest
      t.boolean :private
      t.string :username

      t.timestamps
    end
  end
end
