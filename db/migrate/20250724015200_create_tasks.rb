class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.string :content
      t.boolean :done
      t.references :tweet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
