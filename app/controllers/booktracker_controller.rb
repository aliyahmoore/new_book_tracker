class BooktrackerController < ApplicationController
  before_action :authenticate_user!
  before_action :find_and_set_book, only: [ :show, :edit, :update, :destroy ]

  require "httparty"

  def index
    @recent_books = current_user.books.order(created_at: :desc).limit(5)
    @book_clubs = current_user.book_clubs
  end

  def index_api
    flash[:message] = nil
    @books = Book.all

    if search_keys_selection.present?
      @books = search_filter_chaining_method(search_keys_selection)

      if @books.empty?
        flash[:message] = "No results found for those criteria."
        @books = Book.all
      end
    end
  end

  def new_search
    flash[:message] = nil
    @google_books_instances = []

    if params[:search]
      api_key = "AIzaSyBl02p05boEJBalaIk4vhvhYsQziBUSUyA"
      url = "https://www.googleapis.com/books/v1/volumes?q=#{params[:search]}&maxResults=15&key=#{api_key}"

      response = HTTParty.get(url)
      result = response.parsed_response

      if result["items"]
        @google_books_instances = result["items"]
      else
        flash[:message] = "No search results found. Please try again."
      end
    end
  end

  def create_from_api
    book = Book.find_or_initialize_by(google_id: params[:google_id])

    if book.new_record?
      api_response = params[:google_books_instance]

      book.assign_attributes(
        google_id: api_response["id"],
        title: api_response["volumeInfo"]["title"],
        author: api_response["volumeInfo"]["authors"]&.join(", "),
        genre: api_response["volumeInfo"]["categories"]&.first,
        description: api_response["volumeInfo"]["description"],
        image_url: api_response["volumeInfo"]["imageLinks"]&.dig("thumbnail"),
        status: "To Read",
        user: current_user
      )
    end

    if book.valid? && book.save
      current_user.books << book unless current_user.books.exists?(id: book.id)
      redirect_to book_path(book), notice: "Book added to your list successfully!"
    else
      puts book.errors.full_messages
      redirect_to new_search_path, alert: "Could not save the book. Please try again."
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path, notice: "Book was successfully removed."
  end

  def add_to_user_books
    book = Book.find_by(google_id: params[:id])

    if book
      current_user.books << book unless current_user.books.include?(book)
      redirect_to new_search_path, notice: "Book added to your list successfully!"
    else
      redirect_to new_search_path, alert: "Could not add book to your list. Please try again."
    end
  end
  private

  def api_book_params
    params.require(:book).permit(:title, :author, :genre, :status, :description, :image_url)
  end

  def find_and_set_book
    @book = Book.find_by(id: params[:id])
    redirect_to books_path, alert: "Book not found." unless @book
  end

  def book_params
    params.require(:book).permit(:title, :author, :genre, :status, :image_url, :notes, :start_date, :end_date)
  end
end
