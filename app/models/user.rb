class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  validates :password, presence: true, if: -> { new_record? || canges[crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || canges[crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || canges[crypted_password] }

  has_many :posts, dependent: :destroy
  has_many :boards, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarks_boards, through: :bookmarks, source: :board

  def bookmark(board)
    bookmarks_boards << board
  end

  def unbookmark(board)
    bookmarks_boards.delete(board)
  end

  def bookmark?(board)
    bookmarks_boards.include?(board)
  end

  def own?(object)
    id == object.user_id
  end
end
