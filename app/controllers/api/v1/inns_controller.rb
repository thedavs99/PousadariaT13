class Api::V1::InnsController < ActionController::API
  def show
    begin
      @inn = Inn.find(params[:id])
      @name = @inn.inn_owner.first_name + ' ' + @inn.inn_owner.last_name
    rescue
      render status: 404
    end
  end
end