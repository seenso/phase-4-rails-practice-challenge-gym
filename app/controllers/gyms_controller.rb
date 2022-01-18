class GymsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  # GET /gyms
  def index
    render json: Gym.all
  end

  # GET /gyms/:id
  def show
    render json: find_gym
  end

  # POST /gyms/:id
  def update
    gym = find_gym
    gym.update(gym_params)
    render json: gym
  end

  # DELETE /gyms/:id
  def destroy
    find_gym.destroy
    head :no_content
  end

  private

  def find_gym
    Gym.find(params[:id])
  end

  def gym_params
    params.permit(:name, :address)
  end

  def render_unprocessable_entity_response(invalid)
    render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
  end

  def render_not_found_response
    render json: {error: "Gym not found"}, status: :not_found
  end

end
