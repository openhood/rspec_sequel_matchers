class CreateProfile < Sequel::Migration
  def up
    create_table :profiles do
      primary_key :id
      foreign_key :item_id, :items, :type => Integer
      DateTime    :created_at
      index       :item_id
    end

    alter_table :items do
      add_foreign_key :profile_id, :profile, :type => Integer
    end
  end

  def down
    drop_table :profiles
  end
end
