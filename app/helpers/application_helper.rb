module ApplicationHelper
	def sort_product_listing(params)
		[
			["Sort", root_path(params.map{ |k, v| [k, v.respond_to?(:except) ? v.except(:sort, :order) : v] }.to_h)],
			["Name (A-Z)", root_path(params.deep_merge(product_filter: {sort: :name, order: :asc}))],
			["Name (Z-A)", root_path(params.deep_merge(product_filter: {sort: :name, order: :desc}))]
		]
	end
end
