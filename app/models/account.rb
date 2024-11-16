class Account < ApplicationRecord
  belongs_to :user

  has_many :transactions

  validates :name, presence: { message: "O nome é obrigatório" }
  validates :initial_balance, numericality: { greater_than_or_equal_to: 0, precision: 2, message: "O valor inicial não é válido" }

  def balance
    total_transactions = transactions.where(deleted_at: nil)
                                     .sum("CASE 
                                            WHEN transaction_type = #{Transaction.transaction_types[:credit]} THEN value 
                                            WHEN transaction_type = #{Transaction.transaction_types[:debit]} THEN -value 
                                            ELSE 0 
                                           END")
    initial_balance + total_transactions
  end
end
