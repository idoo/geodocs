class ItemsController < InheritedResources::Base
  def destroy
    require 'fileutils'

    @item = Item.find(params[:id])
    FileUtils.rm_rf @item.document.to_s
    @item.destroy

  end
end
