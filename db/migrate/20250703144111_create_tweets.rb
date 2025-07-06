class CreateTweets < ActiveRecord::Migration[7.2]
  def change
    create_table :tweets do |t|
      t.string :name
      t.string :title
      t.integer :user_id
      t.datetime :date

      t.timestamps
    end
  end
end
