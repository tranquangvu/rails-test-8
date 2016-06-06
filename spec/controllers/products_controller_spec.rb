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
			let!(:filter_params) 		{ { min_price: 50, max_price: 1000 } }

			it 'returns a list of filtered products' do 
				do_request(filter_params)
				expect(assigns(:products).size).to eq 2
				expect(response).to render_template :index
			end
		end
	end

	describe '#new' do 
		def do_request
			get :new
		end

		let!(:user) { create(:user) }

		before { sign_in user } 

		it 'displays product form' do
			do_request
			expect(response).to render_template :new
		end
	end

	describe '#create' do
		def do_request
			post :create, product: product_attributes
		end

		let!(:user) { create(:user) }
		let!(:type) { create(:type) }
		let!(:manufacturer) { create(:manufacturer) }
		let!(:product_attributes) { attributes_for(:product, manufacturer_id: manufacturer.id, type_id: type.id) }

		before { sign_in user }

		it 'creates a product' do
			expect{ do_request }.to change{ Product.count }.from(0).to(1)
			expect(flash[:success]).to eq 'Create product successfully'
			expect(response).to redirect_to assigns(:product)
		end
	end

	describe '#edit' do
		def do_request
			get :edit, id: product.id
		end

		let!(:user) 		{ create(:user) }
		let!(:product) 	{ create(:product) }

		before { sign_in user }

		it 'renders view :edit' do
			do_request
			expect(response).to render_template :edit
		end
	end


	describe '#update' do
		def do_request
			patch :update, params
		end

		let!(:user)								{ create(:user) }
		let!(:new_name) 					{ 'New name' }
		let!(:product)						{ create(:product) }
		let!(:update_params)			{ { name: new_name } }
		let!(:params)							{ { id: product.id, product: update_params } }

		before { sign_in user }

		it 'updates product' do
			do_request
			expect(product.reload.name).to eq new_name
			expect(flash[:success]).to eq 'Update product successfully'
			expect(response).to redirect_to assigns(:product)
		end
	end
end
