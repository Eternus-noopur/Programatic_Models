({
	addItem: function(component, item) {
		this.saveItem(component, item, function(response){
			var state = response.getState();
		});
	},
})