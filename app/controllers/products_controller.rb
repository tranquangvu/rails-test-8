class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
  	@products = Product.all
  end

  def new
  	@product = Product.new
    @types = Type.all
    @manufacturers = Manufacturer.all
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
  	def product_params
  		params.require(:product).permit(:name, :description, :price, :manufacturer_id, :type_id, :image)
  	end

    def set_product
      @product = Product.find(params[:id])
    end
end
