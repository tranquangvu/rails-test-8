class Product < ActiveRecord::Base
	belongs_to :type
	belongs_to :manufacturer

	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment :image, presence: true,
	  content_type: { content_type: /\Aimage\/.*\Z/ },
	  size: { in: 0..10.megabytes }
  validates :name, :description, :price, presence: true

  scope :price, -> (price) { where('price <= ?', price) }
  scope :manufacturer_id, -> (manufacturer_id) { where manufacturer_id: manufacturer_id}

  def self.filter(filter_params)
    result = all
    filter_params.each do |k, v|
      result = result.send(k, v) if v.present?
    end
    result
  end

  def self.sort_fields
  	[:name, :price]
  end

  def self.sort_field_by_id(id)
  	sort_fields[id]
  end
end
