class BooksController < ApplicationController

before_action :correct_book, only: [:edit]

  def top
  end

  def about
  end

   def show
    @book_id = Book.find(params[:id])
    @user = @book_id.user
    @book = Book.new
  end

  def index
    @user = current_user
  	@book = Book.new
  	@books = Book.all
  end

  def create
    @user = current_user
  	@book = Book.new(book_params)
    @book.user_id = current_user.id
	  if @book.save
		 redirect_to book_path(@book.id), notice: "You have creatad book successfully."
	  else
	    @books = Book.all
	    render :index
	  end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
     redirect_to book_path(@book.id), notice: "You have updated user successfully"
    else
      render :edit
    end
  end


  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
 end

private
  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

  def correct_book
    @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to books_path
    end
  end



end
