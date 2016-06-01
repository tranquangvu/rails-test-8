DEFAULT_BRANDS = [
	'New Balance',
	'Nike',
	'Adidas',
	'Puma',
	'Fila',
	'ASICS'
]

DEFAULT_TYPES = [
	'Training Shoe',
	'Running Shoe',
	'Galactic Elite M Running Shoe',
	'Cross-Training Shoe',
	'Womens Cross Training Shoes',
	'Leather Trainer',
	'Basketball Shoe',
	'10 Tennis Shoe',
	'Trainer'
]

# creating brands
DEFAULT_BRANDS.each do |bran_name|
	Manufacturer.create(name: bran_name)	
end

# creating types
DEFAULT_TYPES.each do |type_name|
	Type.create(name: type_name)
end
