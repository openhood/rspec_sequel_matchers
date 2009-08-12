class Comment < Sequel::Model
  many_to_one :item
  many_to_many :items
end