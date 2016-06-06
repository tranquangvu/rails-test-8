class Product < ActiveRecord::Base
	belongs_to :type
	belongs_to :manufacturer

	has_attached_file :image, styles: { thumb: "250x137#", medium: "300x164>" }
  validates_attachment :image, presence: true,
	  content_type: { content_type: /\Aimage\/.*\Z/ },
	  size: { in: 0..10.megabytes }

  validates :name,        presence: true, length: { minimum: 5, maximum: 20 }
  validates :description, presence: true, length: { minimum: 20, maximum: 255 }
  validates :price,       presence: true, numericality: { greater_than: 0 }

  scope :by_price, -> (min, max) { where('price >= ? AND price <= ?', min, max) }
  scope :by_manufacturers, -> (manufacturer_ids) { where(manufacturer_id: manufacturer_ids)}
end