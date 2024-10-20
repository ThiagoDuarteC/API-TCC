class CategoriesController < ApplicationController
  before_action :load_category, only: %i[ show update destroy ]

  def index
    @categories = Category.where(user: current_user, deleted_at: nil)

    render json: @categories
  end

  def show
    render json: @category
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      render json: @category, status: :created, location: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      render json: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @category.update(deleted_at: Time.zone.now)
      render json: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  private
    def load_category
      @category = Category.find_by(id: params[:id], user: current_user, deleted_at: nil)
    end

    def category_params
      params.permit(:name, :user_id, :deleted_at)
    end
end
