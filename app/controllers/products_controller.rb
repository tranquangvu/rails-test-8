class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @product = Product.new
    @product_filter = ProductFilter.new(filter_params)
    @products = @product_filter.search.paginate(:page => params[:page], :per_page => 3)
    
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @product = Product.new(product_params)
    @success = @product.save
    
    if @success
      @product_filter = ProductFilter.new(filter_params)
      @products = @product_filter.search.paginate(:page => params[:page], :per_page => 3)
    end 
  end

  def show; end

  def update
    @success = @product.update(product_params)
  end

  def destroy
    @product.destroy
    redirect_to root_path, :success => 'Delete product successfully'
  end

  private
  def product_params
    params.require(:product).permit(:name,
                                    :description,
                                    :price,
                                    :manufacturer_id,
                                    :type_id,
                                    :image
                                    )
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def filter_params
    return if params[:product_filter].nil?
    data = params.require(:product_filter).permit(:min_price,
                                                  :max_price, 
                                                  :sort,
                                                  :order,
                                                  manufacturer_ids: []
                                                  )
  end
end
