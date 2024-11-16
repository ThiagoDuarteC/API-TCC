class Transaction < ApplicationRecord
  enum transaction_type: [:credit, :debit]

  belongs_to :user
  belongs_to :category
  belongs_to :account

  validates :user, :category, :account, presence: true
  validates :value, numericality: { greater_than_or_equal_to: 0, precision: 2, message: "O valor não é válido" }
  validates :transaction_type, inclusion: { in: transaction_types.keys }
end
