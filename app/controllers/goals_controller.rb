class GoalsController < ApplicationController
  before_action :load_goal, only: %i[ show update destroy ]

  def index
    @goals = Goal.all

    render json: @goals
  end

  def show
    render json: @goal
  end

  def create
    @goal = Goal.new(goal_params)

    if @goal.save
      render json: @goal, status: :created, location: @goal
    else
      render json: @goal.errors, status: :unprocessable_entity
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
      @goal = Goal.find_by(id: params[:id], user_id: params[:user_id])
    end

    def goal_params
      params.permit(:name, :description, :background_color, :icon_name, :deadline, :user_id, :deleted_at)
    end
end
