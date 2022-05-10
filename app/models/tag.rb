class Tag < ApplicationRecord
  has_many :book_tags, dependent: :destroy, foreign_key: "tag_id"
  has_many :books, through: :book_tags

  validates :name, uniqueness: true, presence: true

  def self.looks(word)
      @tag = Tag.where("name LIKE?", "#{word}")
    return @tag.inject(init = []) {|result, tag| result + tag.books}
  end
end
