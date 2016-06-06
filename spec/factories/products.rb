FactoryGirl.define do
	factory :product do
		sequence(:name) 			{ |n| "Product #{n}" }
		price									10.0
		description						'This is a good products'
		image 								Rack::Test::UploadedFile.new(Rails.root + 'spec/fixtures/spec.jpg', 'image/jpg')
		manufacturer
		type
	end
end
