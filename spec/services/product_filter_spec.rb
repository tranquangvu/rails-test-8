require 'rails_helper'

describe ProductFilter do
	describe '#search' do
		let!(:manufacturer1) { create(:manufacturer) }
		let!(:manufacturer2) { create(:manufacturer) }

		before do
			2.times do |t|
				create(:product, price: 5, manufacturer: manufacturer1)				
			end

			3.times do |t|
				create(:product, price: 10, manufacturer: manufacturer2)				
			end
		end

		context 'filter by manufacturer' do
			let!(:product_filter) { ProductFilter.new({ manufacturer_ids: [manufacturer1.id.to_s] }) }

			it 'returns products list belong to manufacturers' do
				expect(product_filter.search.count).to eq 2
			end
		end

		context 'fiter by price' do
			let(:product_filter) { ProductFilter.new({ min_price: 0, max_price: 10 }) }

			it 'returns products list have price match condition' do
				expect(product_filter.search.count).to eq 5
			end
		end

		context 'filter by price and manufacturer' do
			let!(:product_filter) { ProductFilter.new(min_price: 0, max_price: 10, manufacturer_ids: [manufacturer2.id.to_s]) }

			it 'returns products list match price condition and belong to manufacturers' do
				expect(product_filter.search.count).to eq 3
			end
		end
	end
end
