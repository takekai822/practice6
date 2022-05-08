class BooksController < ApplicationController
  before_action :ensure_correct_user, only:[:edit, :update, :destroy]

  def index
    @book = Book.new
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      @books = Book.all
      render "index"
    end
  end

  def show
    @book = Book.find(params[:id])
    @booknew = Book.new
    @bookcomment = BookComment.new
  end

  def edit
  end

  def update
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully"
      redirect_to book_path(@book)
    else
      render "edit"
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to books_path
    end
  end
end
