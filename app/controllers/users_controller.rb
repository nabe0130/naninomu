class UsersController < ApplicationController
  def show
      @user = User.find(params[:id])
      # 他の必要なコード
  end
end
