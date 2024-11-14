class GoalsController < ApplicationController
  before_action :load_goal, only: %i[ show update destroy ]

  def index
    @goals = Goal.where(user: current_user, deleted_at: nil).order(deadline: :desc)

    render json: @goals
  end

  def show
    render json: @goal
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user = current_user

    if @goal.save
      render json: { success: ['Conta criada com sucesso'] }, status: :created, location: @goal
    else
      render json: { errors: ['Erro ao criar conta'] }, status: :unprocessable_entity
    end
  end

  def update
    if @goal.update(goal_params)
      render json: @goal
    else
      render json: @goal.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @goal.update(deleted_at: Time.zone.now)
      render json: @goal
    else
      render json: @goal.errors, status: :unprocessable_entity
    end
  end

  private
    def load_goal
      @goal = Goal.find_by(id: params[:id], user: current_user, deleted_at: nil)
    end

    def goal_params
      params.permit(:name, :description, :value, :background_color, :icon_name, :deadline, :user_id, :deleted_at)
    end
end
