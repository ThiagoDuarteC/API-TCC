class AccountsController < ApplicationController
  before_action :load_account, only: %i[ show edit update destroy ]

  def index
    @accounts = Account.where(user: current_user, deleted_at: nil)
  
    accounts_with_balance = @accounts.map do |account|
      account.attributes.merge(balance: account.balance)
    end
  
    total_balance = @accounts.sum { |account| account.balance }

    render json: { accounts: accounts_with_balance, total_balance: total_balance }
  end

  def show
    render json: @account
  end

  def edit
    render json: @account
  end

  def create
    @account = Account.new(account_params)
    @account.user = current_user
    if @account.save
      render json: { success: ['Conta criada com sucesso'] }, status: :created
    else
      render json: { errors: ['Erro ao criar conta'] }, status: :unprocessable_entity
    end
  end

  def update
    if @account.update(account_params)
      render json: @account
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @account.update(deleted_at: Time.zone.now)
      render json: @account
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  private
    def load_account
      @account = Account.find_by(id: params[:id], user: current_user, deleted_at: nil)
    end

    def account_params
      params.permit(:name, :bank_name, :initial_balance, :user_id, :deleted_at)
    end
end
