include CollectiveIdea::Acts::NestedSet::Helper

ActiveAdmin.register Category do
  filter :parent, :as => :select, :input_html => { :class => "chzn-select"}, :collection => nested_set_options(Category, @category) {|i| "#{'-' * i.level} #{i.title}" }
  filter :title
  filter :path
  filter :created_at
  filter :updated_at
  
  form do |f|
    f.inputs "Category" do
      f.input :parent, :as => :select, :input_html => { :class => "chzn-select"}, :collection => f.template.nested_set_options(Category, @category) {|i| "#{'-' * i.level} #{i.title}" }

      f.input :title
    end
    f.buttons
  end

  controller do

    def new
      @category = Category.new
    end

    def create
      require 'fileutils'

      @category = Category.new(params[:category])

      if @category.parent
        p = @category.parent.path + '/' + @category.title
      else
        p = 'public/data/' + @category.title
      end

      @category.path = p
      FileUtils.mkpath p

      if @category.save
      flash[:success] = "Category '" + @category.title + "' created"
      else
        FileUtils.rmdir p
        flash[:error] = "I can\'t create this category"
      end

      redirect_to admin_categories_path
    end

    def update
      require 'fileutils'

      @category = Category.find(params[:id])

      begin
        ActiveRecord::Base.transaction do
          @category.update_attributes(params[:category])

          new_path = if @category.parent.nil?
            File.join('public', 'data', @category.title)
          else
            File.join(@category.parent.path, @category.title)
          end

          FileUtils.mv(@category.path_was, new_path).zero?

          @category.update_attribute :path, new_path

          # if @category.children.any?
          #   @category.children.each do |c|
          #     c.update_attribute :path, File.join(@category.path, c.title)
          #   end
          # end

        end
        rescue Exception => e
          flash[:error] = 'I can\'t move this'
      end 

      flash[:success] = "Category is updated"

      redirect_to admin_categories_path

    end

    def destroy
      require 'fileutils'

      @category = Category.find(params[:id])
      FileUtils.rm_rf @category.path
      @category.destroy

      flash[:success] = "Category is removed"

      redirect_to admin_categories_path
    end

  end

  index do
    column :title
    column :path
    column :created_at
    column :updated_at
    default_actions

  end
end

