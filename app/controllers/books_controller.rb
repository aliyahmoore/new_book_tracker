class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book_clubs, only: [ :new, :create, :edit, :update ]
  def index
    @books = current_user.books
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    book = current_user.books.build(book_params)

    if book.save
      render json: { message: "Book successfully added to your list!" }, status: :ok
    else
      render json: { error: "Unable to add book to your list." }, status: :unprocessable_entity
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to @book, notice: "Book was successfully updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy!

    redirect_to books_path, status: :see_other
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def set_book_clubs
    @book_clubs = BookClub.all
  end

  def book_params
    params.require(:book).permit(:title, :author, :genre, :status, :book_club_id, :notes, :start_date, :end_date)
  end
end
