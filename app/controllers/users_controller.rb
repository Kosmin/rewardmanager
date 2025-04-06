class UsersController < ApplicationController
  def create
    # Not implemented - in the interest of time, creation is done via the graphql admin or rails console
    render json: { message: "Not implemented" }, status: :not_implemented
  end

  def show
    # just show user details & balance
    render json: UserSerializer.new(current_user).serializable_hash
  end

  def update
    # Not implemented - in the interest of time, updating is done via the graphql admin or rails console
    render json: { message: "Not implemented" }, status: :not_implemented
  end

  def destroy
    # Not implemented - in the interest of time, deletion is done via the graphql admin or rails console
    render json: { message: "Not implemented" }, status: :not_implemented
  end
end
