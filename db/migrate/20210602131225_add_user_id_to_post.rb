class AddUserIdToPost < ActiveRecord::Migration[5.2]
  def change
    execute 'DELETE FROM posts;'
    add_reference :posts, :user, foreign_key: true
  end
end
