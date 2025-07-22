class User < ApplicationRecord
  validates :student_no, presence: true, uniqueness: true
  validates :name, presence: true
  validates :role, presence: true, inclusion: { in: [ "student", "librarian" ] }  # 役割の制限
  validates :password, presence: true

  # パスワードとログイン時に比較
  def authenticate(input_password)
    self.password == input_password
  end
end
