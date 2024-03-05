# frozen_string_literal: true

# UsersControllerはユーザーに関連するアクションを管理します。
# このコントローラでは、ユーザーのプロフィール表示や編集など、
# ユーザーに関する操作を扱います。
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @bookmarks = @user.bookmarks.page(params[:page]).per(5) # 例: 1ページあたり5項目
  end
end
