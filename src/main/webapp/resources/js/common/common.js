$(document).on("blur",".comma",function(){
	var value = $(this).val();
	if(value == ""){
		$(this).val(num_comma(0));
	}else{
		$(this).val(num_comma($(this).val()));
	}
})

$(document).on("focus",".comma",function(){
	var value = $(this).val();
	$(this).val(value.replace(/,/gi,""));
})

function num_comma(val){
	val = val == "" ? 0 : val;
	val = String(val).replace(/,/gi,"")
	val = String(val);
	val = val.replace(/,/gi,"");
	var str = String(val);
	
	if(str.indexOf(".") > -1 ){
		var vlaue = val.split(".");
		return vlaue[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",")+"."+vlaue[1];
	}else{
		return str.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		
	}
}

function getCursor(id)
{
       var ctl = document.getElementById(id);
       var startPos = ctl.selectionStart;
       var endPos = ctl.selectionEnd;
       //alert(startPos + ", " + endPos);
       return startPos;
}

var callAjax = function(url,sync,type,param,callback){
	$.ajax({
		url : url,
		type : "post",
		dataType : type,
		data : param,
		async: sync,
		success : function(data) {
			callback(data);
			serverErr = true;
		},
		error : function(request,status,error){
			console.log("처리중 오류 발생 : "+request.responseText)
			   $('.wrap-loading').addClass('display-none');
		}
		,beforeSend:function(){

	        $('.wrap-loading').removeClass('display-none');

	    } ,complete:function(){

	        $('.wrap-loading').addClass('display-none');

	 

	    }

	});
}

function getJsonFilter(data,key,value,exceptionKey,exceptionValue){
	var arr = new Array();
	var returnObject = null;
	
	$.each(data,function(){
		
		if(this[key] == value){
			arr.push(this);
			returnObject = this;
		}
	})
	return arr;
}


function delHangle(evt){
	var objTarget = evt.srcElement || evt.target;
	var _value = evt.srcElement.value;
	if(/[ㄱ-ㅎㅏ-ㅡ가-핳]/g.test(_value)){
		objTarget.value = null;
	}
}

function isNumberKey(evt) {
	
	
    var charCode = (evt.which) ? evt.which : event.keyCode;
    if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57))
        return false;

    // Textbox value       
    var _value = event.srcElement.value;       
    _value = _value.replace(/,/gi,"");
   
    // 1000 이하의 숫자만 입력가능
    var _pattern1 = /^\d{50}$/; // 현재 value값이 3자리 숫자이면 . 만 입력가능
    if (_pattern1.test(_value)) {
        if (charCode != 46) {
        	$(this).val(1.00);
            return false;
        }
    }
    // 소수점 3자리까지만 입력가능
    
    var _pattern2 = /^\d*[.]\d{3}$/; // 현재 value값이 소수점 둘째짜리 숫자이면 더이상 입력 불가
    var currCursor =  getCursor($(evt.target).attr("id"))
	var indexDot = _value.indexOf(".");
    if (_pattern2.test(_value) && currCursor >  indexDot   ) {
    	
    	
    	clearTimeout(timer);
    	$("#alert").slideDown();
    	timer = setTimeout(function() { $("#alert").slideUp(); }, 2000);
        return false;
    }     

    
    // 소수점(.)이 두번 이상 나오지 못하게
    var _pattern0 = /^\d*[.]\d*$/; // 현재 value값에 소수점(.) 이 있으면 . 입력불가
    if (_pattern0.test(_value)) {
        if (charCode == 46) {
            return false;
        }
    }
    
    return true;
}

function frmNumComma(){
	var len = $(".comma").length;
	for(var i=0;i<len;i++){
		$(".comma").eq(i).val(num_comma( $(".comma").eq(i).val()))
	}
}
function frmNumCommaBreak(){
	var len = $(".comma").length;
	for(var i=0;i<len;i++){
		$(".comma").eq(i).val( String($(".comma").eq(i).val()).replace(/,/gi,"")   );
	}
}

function undefinedReplaceEmpty(args){
	return args == undefined ? "" : args;
}

function ExportToExcel(mytblId){
    var htmltable= document.getElementById(mytblId);
    var html = htmltable.outerHTML;
    window.open('data:application/vnd.ms-excel,' + encodeURIComponent(html));
 }