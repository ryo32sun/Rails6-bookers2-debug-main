class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments , dependent: :destroy
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  def self.looks(search, word)
    if word == ""
      @book = Book.all
    elsif search == "perfect_match"
      @book = Book.where("title LIKE?" , "#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?" , "#{word}%")
    elsif search == "backeard_match"
      @book = Book.where("title LIKE?" , "%#{word}")
    else
      @book = Book.where("title LIKE?" , "%#{word}%")
    end
  end
end
