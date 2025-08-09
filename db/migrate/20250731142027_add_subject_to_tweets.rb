class AddSubjectToTweets < ActiveRecord::Migration[7.2]
  def change
    add_column :tweets, :subject, :string
  end
end
