FactoryGirl.define do
	factory :type do
		sequence(:name) { |n| "Manufacturer #{n}" }
	end
end