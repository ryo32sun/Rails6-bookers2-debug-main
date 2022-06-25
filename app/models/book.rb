class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
  # validates :rate, numericality: {
  #   less_than_or_equal_to: 5,
  #   greater_than_or_equal: 0
  # }, presence: true

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  def self.search(search_word)
    Book.where(['category LIKE?', "#{search_word}"])
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?", "#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?", "#{word}%")
    elsif search == "backeard_match"
      @book = Book.where("title LIKE?", "%#{word}")
    else
      @book = Book.where("title LIKE?", "%#{word}%")
    end
  end
  
end
