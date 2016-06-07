class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @product_filter = ProductFilter.new(filter_params)
  	@products = @product_filter.search.page params[:page]
  end

  def new
  	@product = Product.new
  end

  def create
  	@product = Product.new(product_params)
    
    if @product.save
      redirect_to @product, :success => 'Create product successfully'
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to @product, :success => 'Update product successfully'
    else
      render :edit
    end
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
