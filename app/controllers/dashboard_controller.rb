class DashboardController < ApplicationController
  def index
    start_date = Date.today.beginning_of_month
    end_date = Date.today.end_of_month


    @accounts = Account.where(user: current_user, deleted_at: nil)
  
    current_balance = @accounts.sum { |account| account.balance }

    credit_balance = Transaction.where(transaction_type: :credit , deleted_at: nil, user: current_user, transaction_date: start_date..end_date).sum(:value)

    debit_balance = Transaction.where(transaction_type: :debit , deleted_at: nil, user: current_user, transaction_date: start_date..end_date).sum(:value)

    render json: { current_balance: current_balance, credit_balance: credit_balance, debit_balance: debit_balance }
  end
end
