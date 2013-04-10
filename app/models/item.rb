class Item < ActiveRecord::Base
  attr_accessible :category_id, :document, :title

  belongs_to :category

  mount_uploader :document, DocumentUploader

  validates_presence_of :title, :document, :category_id
end
