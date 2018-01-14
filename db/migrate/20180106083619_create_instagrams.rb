class CreateInstagrams < ActiveRecord::Migration[5.1]
  def change
    create_table :instagrams do |t|
      t.text :content
      t.text :image
      t.integer :user_id
    end
  end
end
