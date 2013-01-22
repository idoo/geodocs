include CollectiveIdea::Acts::NestedSet::Helper

ActiveAdmin.register Item do


  config.per_page = 10
  
  filter :category, :as => :select, :input_html => { :class => "chzn-select"}, :collection => proc { nested_set_options(Category, @category) {|i| "#{'-' * i.level} #{i.title}" } }
  filter :title
  filter :document
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs "Item" do

      f.input :category, :as => :select, :input_html => { :class => "chzn-select"}, :collection => f.template.nested_set_options(Category, @category) {|i| "#{'-' * i.level} #{i.title}" }

      f.input :title
      f.input :document, :as => :file
    end
    f.buttons
  end

  controller do
    def destroy
      require 'fileutils'

      @item = Item.find(params[:id])
      FileUtils.rm_rf @item.document.to_s
      @item.destroy

      redirect_to admin_items_path
    end

    def create
      @item = Item.new(params[:item])

      if @item.title.to_s.empty?
        @item.title = @item.document.to_s.split("/").last
      end

      @item.save

      redirect_to admin_items_path  
    end

  end
  index do
    column :title
    column :document
    column :created_at
    column :updated_at
    default_actions
  end
end

