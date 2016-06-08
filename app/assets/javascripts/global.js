window.RailsTest8 = {
  init: function() {
  	window.materializeForm.init();
  	this.modalInit();
  },
	modalInit: function(){
		$('.modal-trigger').leanModal();
	}
}

$(document).ajaxComplete(function() {
  window.materializeForm.init();
});
