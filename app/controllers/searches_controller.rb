class SearchesController < ApplicationController

  def search
    @range = params[:range]
    
    if @range == 'User'
      @users = User.looks(params[:search], params[:word])
    elsif @range == "Book"
      @books = Book.looks(params[:search], params[:word])
    else
      @tags = Tag.looks(params[:word])
    end
    @book = Book.new
  end

end
