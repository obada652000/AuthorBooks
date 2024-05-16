class BooksController < ApplicationController
  before_action :authenticate_author!
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  def index
    @filterrific = initialize_filterrific(
      Book,
      params[:filterrific]
    ) or return

    @books = @filterrific.find

    respond_to do |format|
      format.html
      format.csv{ send_data @books.to_csv, filename: "books-#{Date.today}.csv" }
    end
  end

  # GET /books/:id
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end


  def create
    @book = current_author.books.new(book_params)
    if @book.save
      flash[:errors] = 'Book Created Successfully'
      redirect_to books_path
    else
      flash[:errors] = @book.errors.full_messages
      redirect_to new_book_path
    end
  end


  # GET /books/:id/edit
  def edit
  end


  def update
    @book = current_author.books.find(params[:id])
    if @book.update(book_params)
      flash[:success] = 'Book Updated Successfully'
      redirect_to books_path
    else
      flash[:errors] = @book.errors.full_messages
      redirect_to edit_book_path
    end
  end


  def destroy
    if @book.delete
      flash[:errors] = 'Book Deleted Successfully'
      redirect_to book_path(@book)
    else
      flash[:errors] = @book.errors.full_messages
      redirect_to destroy_books_path
    end
  end

  private
  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:name, :release_date)
  end

end
