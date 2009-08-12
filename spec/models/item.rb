class Item < Sequel::Model
  plugin :validation_helpers
  one_to_many :comments
end