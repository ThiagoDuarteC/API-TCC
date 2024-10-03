class Account < ApplicationRecord
  belongs_to :user

  validates :name, presence: { message: "O nome é obrigatório" }
  validates :initial_balance, numericality: { greater_than_or_equal_to: 0, precision: 2, message: "O valor inicial não é válido" }
end
