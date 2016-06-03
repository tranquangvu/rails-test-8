class Product < ActiveRecord::Base
	belongs_to :type
	belongs_to :manufacturer

	has_attached_file :image, styles: { thumb: "250x137#", medium: "300x164>" }
  validates_attachment :image, presence: true,
	  content_type: { content_type: /\Aimage\/.*\Z/ },
	  size: { in: 0..10.megabytes }

  validates :name,        presence: true
  validates :description, presence: true
  validates :price,       presence: true

  scope :by_price, -> (max) { where('price <= ?', max) }
  scope :by_manufacturers, -> (manufacturer_ids) { where manufacturer_id: manufacturer_ids}
end