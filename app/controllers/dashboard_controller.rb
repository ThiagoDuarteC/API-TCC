class DashboardController < ApplicationController
  def index
    start_date = Date.today.beginning_of_month
    end_date = Date.today.end_of_month


    @accounts = Account.where(user: current_user, deleted_at: nil)
  
    current_balance = @accounts.sum { |account| account.balance }

    credit_balance = Transaction.where(transaction_type: :credit , deleted_at: nil, user: current_user, transaction_date: start_date..end_date).sum(:value)

    debit_balance = Transaction.where(transaction_type: :debit , deleted_at: nil, user: current_user, transaction_date: start_date..end_date).sum(:value)

    monthly_summary = Transaction.where("EXTRACT(YEAR FROM transaction_date) = ?", Date.current.year)
                                 .where(user: current_user)
                                 .group(Arel.sql("EXTRACT(MONTH FROM transaction_date)"))
                                 .order(Arel.sql("EXTRACT(MONTH FROM transaction_date)"))
                                 .pluck(
                                   Arel.sql("EXTRACT(MONTH FROM transaction_date)::int AS month"),
                                   Arel.sql("SUM(CASE WHEN transaction_type = #{Transaction.transaction_types[:credit]} THEN value WHEN transaction_type = #{Transaction.transaction_types[:debit]} THEN -value ELSE 0 END) AS total_value")
                                 )

    monthly_data = Array.new(12, 0)
    monthly_summary.each do |month, total_value|
      monthly_data[month - 1] = total_value.to_f
    end

    render json: { current_balance: current_balance, credit_balance: credit_balance, debit_balance: debit_balance, monthly_data: monthly_data }
  end
end
