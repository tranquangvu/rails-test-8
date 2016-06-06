require 'rails_helper'

describe Manufacturer do
	context 'validations' do
		it { is_expected.to have_many :products }
	end
end