class Category < ActiveRecord::Base
  acts_as_nested_set dependent: :destroy
  include TheSortableTree::Scopes

  attr_accessible :parent_id, :path, :title, :lft, :rgt, :depth

  # belongs_to :parent, :class_name => 'Category', :counter_cache => true
  # has_many :childrens, :class_name => 'Category', :foreign_key => 'parent_id', :dependent => :destroy

  has_many :items, dependent: :destroy

  validates_presence_of :title, :path

  validates_format_of :title, :with => /\A([[:alnum:]]|\ |\-|_)+\z/

  after_save :update_children_paths

  # Business logic

  def all_childrens
    Category.where(id: _all_childrens)
  end

protected

  def update_children_paths
    children.each do |children|
      children.update_attribute :path, File.join(path, children.title)
    end
  end

  def _all_childrens
    result = []
    children.each do |children|
      result.concat(children._all_childrens)
    end
    children_ids.concat(result)
  end

end

