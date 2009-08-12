class CreateComments < Sequel::Migration

  def up
    create_table  :comments do 
      primary_key :id
      foreign_key :item_id, :items, :type => Fixnum
      String      :content
      DateTime    :created_at
      index       :item_id
    end
  end

  def down
    drop_table    :comments
  end

end