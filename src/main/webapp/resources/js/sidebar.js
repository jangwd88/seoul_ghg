/* require jquery */
$(document).ready(function(){
	/* excepting path */
	var exceptPath = ["bbs"];
	
	/* getPathName */
	var pathName = $(location).attr('pathname');
	
	/* split check */
	var checkDir = pathName.split("/")[1];
	
	var existIdx = exceptPath.indexOf(checkDir);
	/* get A tag find pathname */
	var aList = $("li>a");
	$.each(aList, function(index, _item){
		var item = $(_item);
		var itemHref = item.attr("href");
		var aStr = null, bStr = null;
		if(existIdx!=-1){
			/*exist checkDir*/
			aStr = checkDir;
			bStr = itemHref.split("/")[1];
		}else{
			/*not exist checkDir*/
			aStr = pathName;
			bStr = itemHref;
		}
		
		if(aStr==bStr){
			if(!item.hasClass("active")){
				item.addClass("active");
			}
			var submenu = item.parent().parent();
			if(submenu.hasClass("submenu")){
				var collapse = submenu.parent();
				var colId = collapse.attr("id");
				$("a[href='#"+colId+"']").trigger("click");
			}
		}
	});
});