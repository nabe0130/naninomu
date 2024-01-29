class BookmarksController < ApplicationController

def create
  @drink = Drink.find_by(id: params[:drink_id])
  if @drink
    bookmark = current_user.bookmarks.create(drink: @drink)
    if bookmark.persisted?
      respond_to do |format|
        format.html { redirect_back fallback_location: root_path, notice: 'お気に入りに登録しました。' }
        format.json { render json: { bookmarked: true } }
      end
    else
      render json: { bookmarked: false, error: 'お気に入りの登録に失敗しました。' }, status: :unprocessable_entity
    end
  else
    render json: { error: 'カクテルが見つかりませんでした。' }, status: :not_found
  end
end

def destroy
  @bookmark = current_user.bookmarks.find_by(drink_id: params[:drink_id])
  if @bookmark&.destroy
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path, notice: 'お気に入りを解除しました。' }
      format.json { render json: { bookmarked: false } }
    end
  else
    render json: { error: 'お気に入りを解除できませんでした。' }, status: :unprocessable_entity
  end
end
end