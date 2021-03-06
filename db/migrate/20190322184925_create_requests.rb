class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.string :title
      t.text :description
      t.integer :user_id

      t.timestamps
    end

    add_index :requests, :title
  end
end
