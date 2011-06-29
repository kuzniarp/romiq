

// FONT REPLACEMENT
// Replace all tags with cufon equivalant
Cufon.replace('h1,h2,h3,.standardForm label');
//

// JQUERY
$(function(){
		   
	   // Clear searchform on click
		$("#searchform #s").click(function(){
			$(this).val("");   
		});
		
	
		// Dropdown Menu config
		$("ul.sf-menu").supersubs({ 
            minWidth:    12,   // minimum width of sub-menus in em units 
            maxWidth:    30,   // maximum width of sub-menus in em units 
            extraWidth:  1     // extra width can ensure lines don't sometimes turn over 
                               // due to slight rounding differences and font-family 
        }).superfish();  // call supersubs first, then superfish, so that subs are 
                         // not display:none when measuring. Call before initialising 
                         // containing tabs for same reason.
	
	
	// Softbutton = soft fade on hover, used for social media icons
	$(".softbutton a").stop().fadeTo("fast", .55);
	$(".softbutton a").hover(
		function(){
			$(this).stop().fadeTo("fast", 1);
		},
		function(){
			$(this).stop().fadeTo("fast", .55);
		}
	);
	
	
	$("p.message").click(function(){ $(this).slideUp(500); });
		
	// Fix applied so menu appears OVER cycled images
	// Reverses the default z-index stacking order of the elements
//	var startIndex = 1099;
//	$('div').each(function() {
//		$(this).css('zIndex', startIndex);
//		startIndex -= 1;
//	});
	
$(".nested_lists a:not([class~='toggle'])").hover(
	function () {
		$(this).stop().animate({ marginLeft: "5px" }, 200);
	}, 
	function () {
		$(this).stop().animate({ marginLeft: "0" });
	}
);


});// end jquery