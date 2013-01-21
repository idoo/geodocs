class CategoriesController  < ApplicationController
  include TheSortableTreeController::Rebuild

  def manage
    @category = Category.nested_set.all
  end

  def index
    @category = Category.all
    @page = Page.first
  end

  def show
    @category = Category.find(params[:id])

    @parent_id = @category.parent_id;

    @categories = Category::Category.find(:all, :order => "parent_id desc")
    @crumbs = Array.new
    @categories.each do |category|
      if category.id == @parent_id
        @parent_id = category.parent_id
        @crumbs.push category
      end
    end
    @crumbs = @crumbs.reverse
    rescue ActiveRecord::RecordNotFound
     redirect_to(root_url)
  end

  def new
    @category = Category.new  
  end

  def create
    @category = Category.new(params[:category])
  end
end
