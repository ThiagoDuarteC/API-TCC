class TransactionsController < ApplicationController
  before_action :load_transaction, only: %i[ show update destroy ]

  def index
    @transactions = Transaction.where(user_id: params[:current_user], deleted_at: nil)

    render json: @transactions
  end

  def show
    render json: @transaction
  end

  def create
    @transaction = Transaction.new(transaction_params)

    if @transaction.save
      render json: @transaction, status: :created, location: @transaction
    else
      render json: @transaction.errors, status: :unprocessable_entity
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
      @transaction = Transaction.find_by(id: params[:id], user_id: params[:current_user], deleted_at: nil)
    end

    def transaction_params
      params.permit(:description, :value, :transaction_type, :user_id, :category_id, :account_id, :deleted_at)
    end
end
