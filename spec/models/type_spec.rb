require 'rails_helper'

describe Type do
	context 'validations' do
		it { is_expected.to validate_presence_of :name }
	end

	context 'associations' do
		it { is_expected.to have_many :products}
	end
end
