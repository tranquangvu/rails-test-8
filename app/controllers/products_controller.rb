class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :init_default_params, only: [:index]

  def index
  	@products = Product.filter(filter_params).order(sort_field)
  end

  def new
  	@product = Product.new
  end

  def create
  	@product = Product.new(product_params)
    if @product.save
      redirect_to @product, :success => 'Create product successfully'
    else
      render :new, :error => 'Errors when create product'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to @product, :success => 'Update product successfully'
    else
      render :edit, :error => 'Errors when update product'
    end
  end

  def destroy
    @product.destroy
    redirect_to root_path, :success => 'Delete product successfully'
  end

  private
    def init_default_params
      @manufacturer_id ||= params[:manufacturer_id]
      @price ||= params[:price]
      @sort_field_id = params[:sort_field_id].to_i
    end

  	def product_params
  		params.require(:product).permit(:name, :description, :price, :manufacturer_id, :type_id, :image)
  	end

    def set_product
      @product = Product.find(params[:id])
    end

    def filter_params
      params.slice(:price, :manufacturer_id)
    end

    def sort_field
      Product.sort_field_by_id(params[:sort_field_id].to_i)
    end
end
