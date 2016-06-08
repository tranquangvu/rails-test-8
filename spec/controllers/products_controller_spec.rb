require 'rails_helper'

describe ProductsController do 
  describe '#index' do 
    def do_request(filter_params = nil)
      get :index, product_filter: filter_params
    end

    let!(:products) { create_list(:product, 2, price: 100) }

    context 'without filter' do
      it 'returns a list of products' do 
      do_request
      expect(assigns(:products).size).to eq 2
      expect(response).to render_template :index
      end
    end

    context 'filter' do 
      let!(:another_products) { create_list(:product, 1, price: 2000) }
      let!(:filter_params)    { { min_price: 50, max_price: 1000 } }

      it 'returns a list of filtered products' do 
      do_request(filter_params)
      expect(assigns(:products).size).to eq 2
      expect(response).to render_template :index
      end
    end
  end

  describe '#show' do
    def do_request
      get :show, id: product.id
    end

    let!(:product)            { create(:product) }

    it 'assigns product' do
      do_request
      expect(assigns(:product)).to eq product
    end

    it 'renders the :show view' do
      do_request
      expect(response).to render_template :show
    end
  end

  describe '#create' do
    def do_request
      post :create, product: product_attributes, format: :js
    end

    let!(:user)               { create(:user) }
    let!(:type)               { create(:type) }
    let!(:manufacturer)       { create(:manufacturer) }
    let!(:product_attributes) { attributes_for(:product, manufacturer_id: manufacturer.id, type_id: type.id) }

    before { sign_in user }

    it 'creates a product' do
      expect{ do_request }.to change{ Product.count }.from(0).to(1)
    end
  end

  describe '#update' do
    def do_request
      patch :update, params
    end

    let!(:user)               { create(:user) }
    let!(:new_name)           { 'New name' }
    let!(:product)            { create(:product) }
    let!(:update_params)      { { name: new_name } }
    let!(:params)             { { id: product.id, product: update_params, format: :js } }

    before { sign_in user }

    it 'updates product' do
      do_request
      expect(product.reload.name).to eq new_name
    end
  end

  describe '#destroy' do
    def do_request
      delete :destroy, id: product.id
    end

    let!(:product)            { create(:product) }
    let!(:user)               { create(:user) }

    before { sign_in user }

    it 'deletes the product' do
      expect{ do_request }.to change{ Product.count }.from(1).to(0)
      expect(flash[:success]).to eq('Delete product successfully')
      expect(response).to redirect_to root_path
    end
  end
end
