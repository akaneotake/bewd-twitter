class CreateTweets < ActiveRecord::Migration[6.1]
  def change
    create_table :tweets do |t|
      t.string :message, null: false
      t.references :user, null: false, foreign_key: true, index: true, type: :integer

      t.timestamps
    end
  end
end
