class ReportsController < ApplicationController
  def category_by_debit
    @debit_category_totals = Transaction.where(user: current_user, deleted_at: nil, transaction_type: 'debit')
                                  .joins(:category)
                                  .group('categories.id, categories.name')
                                  .sum(:value)

    render json: { categories: @debit_category_totals }
  end

  def category_by_credit
    @credit_category_totals = Transaction.where(user: current_user, deleted_at: nil, transaction_type: 'credit')
                                  .joins(:category)
                                  .group('categories.id, categories.name')
                                  .sum(:value)

    render json: { categories: @credit_category_totals }
  end

  def balance_per_account
    @accounts = Account.where(user: current_user, deleted_at: nil).order(created_at: :asc)

    accounts_with_balance = @accounts.map do |account|
      { name: account.name, balance: account.balance }
    end

    render json: { accounts: accounts_with_balance }
  end
end
