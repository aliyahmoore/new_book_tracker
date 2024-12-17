class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book_clubs, only: [ :new, :create, :edit, :update ]
  before_action :set_book, only: [ :show, :edit, :update, :destroy ]

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
    @book = current_user.books.build(book_params)

    if @book.save
      redirect_to @book
    else
      render :new, status: :unprocessable_entity
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
    @book.destroy

    redirect_to root_path, status: :see_other
  end

  def add_to_user_books
    book = Book.find_by(google_id: params[:google_id]) # Assuming 'google_id' is the unique identifier for your books
    if book
      current_user.books << book
      redirect_to new_search_path, notice: "Book added to your list successfully!"
    else
      redirect_to new_search_path, alert: "Could not add book to your list. Please try again."
    end
  end

  private

  def set_book_clubs
    @book_clubs = BookClub.all
  end

  def set_book
    @book = current_user.books.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Book not found."
  end

  def book_params
    params.require(:book).permit(:title, :author, :genre, :status, :book_club_id, :notes, :start_date, :end_date)
  end
end
