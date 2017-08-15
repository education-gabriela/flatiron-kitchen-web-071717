class RecipesController < ApplicationController
  before_action :set_recipe!, only: [:show, :edit, :update]
  before_action :set_ingredients!, only: [:new, :edit]

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.valid?
      @recipe.save
      redirect_to recipe_path(@recipe)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update

    @recipe.ingredients.clear if recipe_params[:ingredient_ids].nil?
    @recipe.update(recipe_params)

    redirect_to recipe_path(@recipe) and return if @recipe.valid?

    render :edit
  end
  private
  def set_recipe!
    @recipe = Recipe.find(params[:id])
  end

  def set_ingredients!
    @ingredients = Ingredient.all
  end

  def recipe_params
    params.require(:recipe).permit(:name, ingredient_ids: [])
  end
end