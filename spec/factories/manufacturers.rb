FactoryGirl.define do 
	factory :manufacturer do 
		sequence(:name) { |n| "Manufacturer #{n}" }

		trait :with_products do |manufacturer|
			transient do 
				products_count 2
			end

			after(:create) do |manufacturer, evaluator|
				create_list(:product, evaluator.products_count, manufacturer: manufacturer)
			end
		end
	end
end