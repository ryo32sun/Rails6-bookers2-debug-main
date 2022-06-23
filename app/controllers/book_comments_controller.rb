class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = @book.id
    comment.save
    @book_comment = BookComment.new
    # redirect_to request.referer
  end

  def destroy
    BookComment.find(params[:id]).destroy
    # redirect_to request.referer
    @book = Book.find(params[:book_id])
    @book_comment = BookComment.new
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
