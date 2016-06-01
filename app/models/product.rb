class Product < ActiveRecord::Base
	belongs_to :type
	belongs_to :manufacturer

	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment :image, presence: true,
	  content_type: { content_type: /\Aimage\/.*\Z/ },
	  size: { in: 0..10.megabytes }
  validates :name, :description, :price, presence: true
end
