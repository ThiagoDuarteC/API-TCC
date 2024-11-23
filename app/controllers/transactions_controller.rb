class TransactionsController < ApplicationController
  before_action :load_transaction, only: %i[ show update destroy ]
  before_action :set_load_info, only: %i[ show load_info ]

  def index
    @transactions = Transaction.includes(:category, :account)
                               .where(user: current_user, deleted_at: nil)
                               .order(created_at: :desc)
  
    render json: @transactions.as_json(
      include: {
        category: { only: :name },
        account: { only: :name }
      }
    )
  end

  def show
    render json: {
      transaction: @transaction,
      categories: @categories,
      accounts: @accounts,
      goals: @goals
    }
  end

  def load_info
    render json: {
      categories: @categories,
      accounts: @accounts,
      goals: @goals
    }
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.user = current_user

    if @transaction.save
      render json: { success: ['Transação criada com sucesso'] }, status: :created, location: @transaction
    else
      render json: { errors: ['Erro ao criar transação'] }, status: :unprocessable_entity
    end
  end

  def update
    if @transaction.update(transaction_params)
      render json: @transaction
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @transaction.destroy!
  end

  private
    def load_transaction
      @transaction = Transaction.find_by(id: params[:id], user: current_user, deleted_at: nil)
    end

    def set_load_info
      @categories = Category.select(:id, :name).where(deleted_at: nil, user: [current_user, nil])
      @accounts = Account.select(:id, :name).where(deleted_at: nil, user: current_user)
      @goals = Goal.select(:id, :name).where(deleted_at: nil, user: current_user)
    end

    def transaction_params
      params.permit(:description, :value, :transaction_type, :transaction_date, :user_id, :category_id, :account_id, :goal_id, :deleted_at)
    end
end
