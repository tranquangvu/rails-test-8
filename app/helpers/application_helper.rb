module ApplicationHelper
	def sort_product_listing
		options = params.dup
		options[:product_filter] = options[:product_filter].except(:sort, :order) if options[:product_filter].present?

		[
			["Sort", root_path(options)],
			["Name (A-Z)", root_path(options.deep_merge(product_filter: {sort: :name, order: :asc}))],
			["Name (Z-A)", root_path(options.deep_merge(product_filter: {sort: :name, order: :desc}))]
		]
	end
end
