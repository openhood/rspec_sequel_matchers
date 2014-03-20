class CreateProfile < Sequel::Migration
  def up
    create_table :profile do
      primary_key :id
      foreign_key :item_id, :items, :type => Fixnum
      DateTime    :created_at
      index       :item_id
    end

    alter_table :items do
      add_foreign_key :profile_id, :profile, :type => Fixnum
    end
  end

  def down
    drop_table :profile
  end
end
