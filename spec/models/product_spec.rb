require 'rails_helper'

describe Product do
	context 'validations' do
		it { is_expected.to validate_presence_of :name }
		it { is_expected.to validate_length_of(:name).is_at_least(5).is_at_most(20) }
		it { is_expected.to validate_presence_of :description }
		it { is_expected.to validate_length_of(:description).is_at_least(20).is_at_most(255) }
		it { is_expected.to validate_presence_of :price }
		it { is_expected.to validate_numericality_of(:price).is_greater_than(0) }
		it { is_expected.to have_attached_file(:image) }
	  it { is_expected.to validate_attachment_presence(:image) }
	  it { is_expected.to validate_attachment_content_type(:image).
	                allowing('image/png', 'image/gif').
	                rejecting('text/plain', 'text/xml') }
	  it { is_expected.to validate_attachment_size(:image).
	                in(0..10.megabytes) }
	end

	context 'associations' do
		it { is_expected.to belong_to :type }
		it { is_expected.to belong_to :manufacturer }
	end

	describe '.by_price' do
		before do
			create_list(:product, 2, price: 100)
			create_list(:product, 2, price: 600)
		end

		it 'return list of products with max price' do
			expect(Product.by_price(0, 500).size).to eq 2
		end
	end

	describe '.by_manufacturers' do
	  let!(:manufacturer) { create(:manufacturer, :with_products, products_count: 3) }

	  it 'returns a list of products searching by manufacturer' do
	  	expect(Product.by_manufacturers(manufacturer.id).size).to eq 3
		end
	end
end