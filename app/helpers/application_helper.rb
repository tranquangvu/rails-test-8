module ApplicationHelper
	def sort_product_listing(params)
		[
			["Name (A-Z)", root_path(params.deep_merge(product_filter: {sort: :name, order: :asc}))],
			["Name (Z-A)", root_path(params.deep_merge(product_filter: {sort: :name, order: :desc}))]
		]
	end
end
