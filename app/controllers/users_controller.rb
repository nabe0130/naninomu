class UsersController < ApplicationController
  def show
      @user = User.find(params[:id])
      @bookmarks = @user.bookmarks.page(params[:page]).per(5) # 例: 1ページあたり5項目
  end
end
