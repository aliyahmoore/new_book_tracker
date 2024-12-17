class BookClubsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book_club, only: [ :show, :edit, :update, :destroy ]

  def index
    @book_clubs = current_user.book_clubs.all
  end

  def show
    @book_club = BookClub.find(params[:id])
    @books = @book_club.books
  end

  def new
    @book_club = BookClub.new
  end

  def create
    @book_club = current_user.book_clubs.new(book_club_params)
    if @book_club.save
      redirect_to @book_club, notice: "Book club was successfully created."
    else
      render :new
    end
  end

  def edit
    @book_club = BookClub.find(params[:id])
  end

  def update
    @book_club = BookClub.find(params[:id])

    if @book_club.update(book_club_params)
      redirect_to @book_club
    else
      render :edit
    end
  end

  def destroy
    @book_club = BookClub.find(params[:id])
    @book_club.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def set_book_club
    @book_club = BookClub.find(params[:id])
  end

  def book_club_params
    params.require(:book_club).permit(:name, :description)
  end
end
