class FavoritesInnsController < ApplicationController

  def new
    @favorites_inn = FavoritesInn.new
    @inn = Inn.find(params[:inn_id])
    @favorite_lists = current_user.favorite_lists
  end

  def create
    @inn = Inn.find(params[:inn_id])
    favorites_inn_params = params.require(:favorites_inn).permit(:favorite_list_id)
    @favorites_inn = @inn.favorites_inns.build(favorites_inn_params)
    favorite_list = @favorites_inn.favorite_list
    if @favorites_inn.save
      redirect_to favorite_list, notice: 'Pousada adicionada com sucesso'
    end
  end

  def destroy
    @favorites_inn = FavoritesInn.find(params[:id])
    if @favorites_inn.delete
      redirect_back_or_to root_path, notice: 'Pousada removida com sucesso'
    end
  end
end