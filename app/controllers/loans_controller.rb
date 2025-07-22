class LoansController < ApplicationController
  before_action :set_user
  before_action :set_book, only: [ :create, :return_book ]

  # 本を借りる
  def create
    if @book.total_copies > 0
      @loan = @user.loans.new(book: @book, loaned_on: Date.today)

      if @loan.save
        @book.update_stock!  # 在庫を減らす
        redirect_to user_loans_path(@user), notice: "Book borrowed successfully."
      else
        redirect_to user_loans_path(@user), alert: "Could not borrow the book."
      end
    else
      redirect_to user_loans_path(@user), alert: "Sorry, this book is out of stock."
    end
  end

  # 本を返却する
  def return_book
    @loan = @user.loans.find_by(book_id: @book.id, returned_on: nil)

    if @loan
      @loan.update(returned_on: Date.today)
      @book.return_book!  # 在庫を戻す
      redirect_to user_loans_path(@user), notice: "Book returned successfully."
    else
      redirect_to user_loans_path(@user), alert: "No loan record found for this book."
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_book
    @book = Book.find(params[:book_id])
  end
end
