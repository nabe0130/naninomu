class CocktailsController < ApplicationController
  def index
    @cocktails =Drink.fetch_cocktails
  end
end
