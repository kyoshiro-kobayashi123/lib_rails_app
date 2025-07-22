# app/models/book.rb
class Book < ApplicationRecord
  has_many :loans
  has_many :users, through: :loans

  # 在庫数の更新
  def update_stock!
    update(total_copies: total_copies - 1)
  end

  def return_book!
    update(total_copies: total_copies + 1)
  end
end
