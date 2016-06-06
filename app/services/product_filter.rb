class ProductFilter
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :manufacturer_ids, :min_price, :max_price, :sort, :order

  def initialize(attributes)
    return if attributes.nil?
    attributes.each { |name, value| send("#{name}=", value.kind_of?(Array) ? value.reject(&:empty?).collect(&:to_i) : value) }
  end

  def search
    return @products if @products.present?
    @products = Product.all 

    @products = @products.by_manufacturers(manufacturer_ids) if manufacturer_ids.present?
    @products = @products.by_price(min_price, max_price) if min_price.present? && max_price.present?
  
    @products = @products.order("#{sort} #{order}") if sort.present? && order.present?
    
    @products
  end

  def persisted?
    false
  end
end