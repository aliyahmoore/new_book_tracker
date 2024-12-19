class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book

  def create
    @comment = @book.comments.new(comment_params)

    if @comment.save
      redirect_to @book, notice: "Comment was successfully added."
    else
      redirect_to @book, alert: "Failed to add comment. Please check the input."
    end
  end

  def destroy
    @comment = @book.comments.find(params[:id])
    @comment.destroy

    redirect_to book_path(@book), notice: "Comment was successfully deleted."
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def comment_params
    params.require(:comment).permit(:title, :body, :date)
  end
end
