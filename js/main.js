

function endsWith(str, suffix) {
	
    return str.indexOf(suffix, str.length - suffix.length) !== -1;
    
}


function selectMenu() {

	var url = document.URL;
	
	$("#menuId").children().map(function() {
	   var child = $(this);
	   var href = child.attr('href');
	   if (endsWith(url, href)) {
		   child.removeClass("extra");
	   }
	});

}


