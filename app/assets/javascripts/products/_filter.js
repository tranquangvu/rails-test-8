window.RailsTest8.productsFilter = {
	init: function() {
		this.initSlider()
	},
	initSlider: function() {
    var slider = document.getElementById('price-slider');
    
    noUiSlider.create(slider, {
      start: [$('#product_filter_min_price').val(), $('#product_filter_max_price').val()],
        connect: true,
        step: 1,
        range: {
          'min': parseInt(slider.getAttribute('min')),
          'max': parseInt(slider.getAttribute('max'))
        },
        format: wNumb({
          decimals: 0
        })
    });

    slider.noUiSlider.on('update', function(values, handle){
      var min_price = $('#product_filter_min_price');
      var max_price = $('#product_filter_max_price');
      (handle ? max_price : min_price).val(values[handle]);
    });
	}
}
