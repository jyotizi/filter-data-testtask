class Api::V1::UsersController < ApplicationController

  def index
    @users = User.all
	  if request.format == :html
	    render :index
	  elsif request.format == :json
	    render json: @users
	  end
  end

	def create
	  @user = User.new(user_params)
	  if @user.save
	    redirect_to api_v1_users_path, notice: "User created successfully"
	  else
	    render :index
	  end
	end

  def filter
    campaign_names = params[:campaign_names].split(',')
  	@users = User.where("JSON_CONTAINS(campaigns_list, ?) > 0", campaign_names.map { |name| { campaign_name: name } }.to_json)
  	render json: @users
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, campaigns_list: [:campaign_name, :campaign_id])
  end

end
