class FavoriteListsController < ApplicationController
  before_action :validate_user 
  def index
    @favorite_lists = current_user.favorite_lists
  end

  def new
    @favorite_list = FavoriteList.new
  end

  def create
    favorite_list_params = params.require(:favorite_list).permit(:name)
    @favorite_list = FavoriteList.new(favorite_list_params)
    @favorite_list.user = current_user
    if @favorite_list.save
      redirect_to favorite_lists_path, notice: 'Lista de favoritos criada com sucesso'
    else
      flash.now[:alert] = 'Nome não pode ficar em branco'
      render :new
    end
  end

  def show
    @favorite_list = FavoriteList.find(params[:id])
  end
  
  private

  def validate_user
    redirect_to new_user_session_path unless current_user
  end
end