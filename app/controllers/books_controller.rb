class BooksController < ApplicationController
  def index
    @book = Book.new
  end

  def create
    @book = Book.new
    if @book.save
      redirect_to @book, notice: "Book was successfully created."
    else
      render :new
    end
    @book = Book.new(title: "タイトル", content: "内容")
    @book.save
  end
  private
    def book_params
      params.require(:book).permit(:title, :content)
    end
end
