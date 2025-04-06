class RedemptionsController < ApplicationController
  # before_action :authenticate_user!

  before_action :validate_reward_presence, only: [ :create ]
  before_action :validate_sufficient_balance, only: [ :create ]

  def index
    @redemptions = current_user.redemptions.includes(:reward).order(created_at: :desc)
    render json: RedemptionSerializer.new(@redemptions).serializable_hash, status: :ok
  end

  def create
    @redemption = current_user.redeem!(reward)

    if @redemption.persisted?
      render json: RedemptionSerializer.new(@redemption).serializable_hash, status: :created
    else
      render json: { errors: @redemption.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    # Not implemented - only works with lists of redemptions for now
    render json: { message: "Not implemented" }, status: :not_implemented
  end

  def update
    # Not implemented
    render json: { message: "Not implemented" }, status: :not_implemented
  end

  def destroy
    # Not implemented
    render json: { message: "Not implemented" }, status: :not_implemented
  end

  private

  def validate_reward_presence
    if reward.blank?
      render json: { errors: [ "Reward not found" ] }, status: :not_found
    end
  end

  def validate_sufficient_balance
    unless current_user.can_redeem?(reward)
      render json: { errors: [ "Cannot redeem reward: insufficient points or already redeemed" ] }, status: :unprocessable_entity
    end
  end

  def redemption_params
    @redemption_params ||= params.require(:redemption).permit(:user_id, :reward_id)
  end

  def reward_params
    @reward_params ||= params.permit(:reward_id)
  end

  def reward
    @reward ||= Reward.find_by(id: reward_params[:reward_id])
  end
end
