class ChangeMessageInTweetsToNotNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :tweets, :message, false
  end
end
