class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book_clubs, only: [ :new, :create, :edit, :update ]
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    @book = current_user.books.new(book_params)

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
      redirect_to @book
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_url
  end

  private

  def set_book_clubs
    @book_clubs = BookClub.all
  end

  def book_params
    params.require(:book).permit(:title, :author, :genre, :status, :book_club_id, :notes, :start_date, :end_date)
  end
end
