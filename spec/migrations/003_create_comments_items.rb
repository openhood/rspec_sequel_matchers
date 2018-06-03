class CreateCommentsItems < Sequel::Migration

  def up
    create_table  :comments_items do
      foreign_key :comment_id, :comments, :type => Integer
      foreign_key :item_id, :items, :type => Integer
      index       [:comment_id, :item_id], :unique => true
    end
  end

  def down
    drop_table    :comments_items
  end

end
