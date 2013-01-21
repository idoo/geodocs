class RebuildController < ApplicationController
  
  def make
    require 'fileutils'

    items = Item.all #items in the db
    categories = Category.all #categories in the db
    
    #empty array for items
    i_array = Array.new

    #empty array for categories
    c_array = Array.new

    saved = true
    while saved do
      saved = false
      Dir.glob('public/data/**/*/').each do |dirname|
        path = dirname.chop.to_s
        dir_name = path.split('/').last.to_s
        parent_path = path.chomp(dir_name.to_s).chop

        if Category.find_by_path(path).nil?
          #move category  
          new_name = dir_name.gsub(/[^a-zA-Z0-9\_\-\ ]/, '')
          FileUtils.mv(dirname, parent_path + "/" + new_name) if new_name != dir_name
          path = parent_path + "/" + new_name


          parent = Category.find_by_path(parent_path)
    
          category = Category.new
          category.title = new_name
          category.path = path
          category.parent_id = parent.id if parent

          break if saved = category.save
        end
      end
    end

    #add /public to items path
    items.each do |i|
      i_array << "public" + i.document.to_s  
    end


    Dir.glob('public/data/**/*.*').each do |filename|
      new_filename = File.basename(filename).gsub(/[ ,^]/, '_')
      File.rename(filename, File.join(File.dirname(filename), new_filename))
    end

    files = Dir.glob('public/data/**/*.*') #in disk

    @list = files - i_array

    @list.each do |l|
      item = Item.new
      item.category_id = Category.find_by_path(File.dirname(l)).id
      item.title = File.basename(l)
      item.document = File.open(File.join(Rails.root, l))

      item.save
    end
    
    flash[:success] = "Links are successfuly rebuilded"

    redirect_to admin_items_path  

  end
end

