class Api::V1::UsersController < Api::V1::BaseController

  def index
    render json:
      ActiveModel::Serializer::CollectionSerializer.new(
        User.ordered.page(params[:page]), serializer: UserSerializer
      )
  end
end
