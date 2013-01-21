class SearchController < ApplicationController
  def index
    # @search = Item.search(params[:search].presence || {:id_lt => 0})
    # @Items = @search.all
    @search = Item.search(params[:search])

    if params[:search].present?
      category_ids = Category.select(:id).search(params[:search]).to_a.map{ |c| c.id } 
      item_ids = Item.select(:id).search(params[:search]).to_a.map{ |i| i.id } 

      @Items = Item.where{ (id >> my{item_ids}) | (category_id >> my{category_ids}) }
    end

    @searchable = params[:search].present?
  end
end

