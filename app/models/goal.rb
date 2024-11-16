class Goal < ApplicationRecord
  belongs_to :user

  has_many :transactions

  validates :name, presence: { message: "O nome é obrigatório" }
  #validates :icon_name, presence: { message: "O icone é obrigatório" }

  def balance
    transactions.where(deleted_at: nil)
                .sum("CASE 
                      WHEN transaction_type = #{Transaction.transaction_types[:credit]} THEN value 
                      WHEN transaction_type = #{Transaction.transaction_types[:debit]} THEN -value 
                      ELSE 0 
                     END")
  end
end
