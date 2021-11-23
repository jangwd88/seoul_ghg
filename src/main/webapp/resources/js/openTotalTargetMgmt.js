$(document).ready(function(){ 
	fn_init();
	fn_cal();
});



$("input").on("change keyup paste", function(){
 
  var val1 = $(this).val();
  
  if($(this).parent().parent().children().length==7){
	    
		 var val_2025 = $(this).parent().parent().children().eq(3);
		 var val_2030 = $(this).parent().parent().children().eq(4);
		 var val_2040 = $(this).parent().parent().children().eq(5);
		 var val_2050 = $(this).parent().parent().children().eq(6);
		 val_2025.text((val1 * 0.8).toFixed(3));
		 val_2030.text((val1 * 0.6).toFixed(3));
		 val_2040.text((val1 * 0.09).toFixed(3));
		 val_2050.text((val1 * 0.02).toFixed(3));
  
  }else{
	  
	 	 var val_2025 = $(this).parent().parent().children().eq(2);
		 var val_2030 = $(this).parent().parent().children().eq(3);
		 var val_2040 = $(this).parent().parent().children().eq(4);
		 var val_2050 = $(this).parent().parent().children().eq(5);
		 val_2025.text((val1 * 0.8).toFixed(3));
		 val_2030.text((val1 * 0.6).toFixed(3));
		 val_2040.text((val1 * 0.09).toFixed(3));
		 val_2050.text((val1 * 0.02).toFixed(3));
	  
  }

});

function fn_cal(){
	
	var w2025 = 0.8;
	var w2030 = 0.6;
	var w2040 = 0.09;
	var w2050 = 0.02;
	
	$('#03_2025').text( ($('#input_03').val()*w2025).toFixed(3));
	$('#03_2030').text( ($('#input_03').val()*w2030).toFixed(3));
	$('#03_2040').text( ($('#input_03').val()*w2040).toFixed(3));
	$('#03_2050').text( ($('#input_03').val()*w2050).toFixed(3));
	
	$('#04_2025').text( ($('#input_04').val()*w2025).toFixed(3));
	$('#04_2030').text( ($('#input_04').val()*w2030).toFixed(3));
	$('#04_2040').text( ($('#input_04').val()*w2040).toFixed(3));
	$('#04_2050').text( ($('#input_04').val()*w2050).toFixed(3));

	$('#07_2025').text( ($('#input_07').val()*w2025).toFixed(3));
	$('#07_2030').text( ($('#input_07').val()*w2030).toFixed(3));
	$('#07_2040').text( ($('#input_07').val()*w2040).toFixed(3));
	$('#07_2050').text( ($('#input_07').val()*w2050).toFixed(3));
	
	$('#14_2025').text( ($('#input_14').val()*w2025).toFixed(3));
	$('#14_2030').text( ($('#input_14').val()*w2030).toFixed(3));
	$('#14_2040').text( ($('#input_14').val()*w2040).toFixed(3));
	$('#14_2050').text( ($('#input_14').val()*w2050).toFixed(3));
	
	$('#10_2025').text( ($('#input_10').val()*w2025).toFixed(3));
	$('#10_2030').text( ($('#input_10').val()*w2030).toFixed(3));
	$('#10_2040').text( ($('#input_10').val()*w2040).toFixed(3));
	$('#10_2050').text( ($('#input_10').val()*w2050).toFixed(3));
	
	
	$('#11_2025').text( ($('#input_11').val()*w2025).toFixed(3));
	$('#11_2030').text( ($('#input_11').val()*w2030).toFixed(3));
	$('#11_2040').text( ($('#input_11').val()*w2040).toFixed(3));
	$('#11_2050').text( ($('#input_11').val()*w2050).toFixed(3));
	
	$('#05_2025').text( ($('#input_05').val()*w2025).toFixed(3));
	$('#05_2030').text( ($('#input_05').val()*w2030).toFixed(3));
	$('#05_2040').text( ($('#input_05').val()*w2040).toFixed(3));
	$('#05_2050').text( ($('#input_05').val()*w2050).toFixed(3));
	
	$('#20_2025').text( ($('#input_20').val()*w2025).toFixed(3));
	$('#20_2030').text( ($('#input_20').val()*w2030).toFixed(3));
	$('#20_2040').text( ($('#input_20').val()*w2040).toFixed(3));
	$('#20_2050').text( ($('#input_20').val()*w2050).toFixed(3));
	
	$('#18_2025').text( ($('#input_18').val()*w2025).toFixed(3));
	$('#18_2030').text( ($('#input_18').val()*w2030).toFixed(3));
	$('#18_2040').text( ($('#input_18').val()*w2040).toFixed(3));
	$('#18_2050').text( ($('#input_18').val()*w2050).toFixed(3));
	
	$('#15_2025').text( ($('#input_15').val()*w2025).toFixed(3));
	$('#15_2030').text( ($('#input_15').val()*w2030).toFixed(3));
	$('#15_2040').text( ($('#input_15').val()*w2040).toFixed(3));
	$('#15_2050').text( ($('#input_15').val()*w2050).toFixed(3));
	
	$('#17_2025').text( ($('#input_17').val()*w2025).toFixed(3));
	$('#17_2030').text( ($('#input_17').val()*w2030).toFixed(3));
	$('#17_2040').text( ($('#input_17').val()*w2040).toFixed(3));
	$('#17_2050').text( ($('#input_17').val()*w2050).toFixed(3));
	
	$('#19_2025').text( ($('#input_19').val()*w2025).toFixed(3));
	$('#19_2030').text( ($('#input_19').val()*w2030).toFixed(3));
	$('#19_2040').text( ($('#input_19').val()*w2040).toFixed(3));
	$('#19_2050').text( ($('#input_19').val()*w2050).toFixed(3));
	
	$('#09_2025').text( ($('#input_09').val()*w2025).toFixed(3));
	$('#09_2030').text( ($('#input_09').val()*w2030).toFixed(3));
	$('#09_2040').text( ($('#input_09').val()*w2040).toFixed(3));
	$('#09_2050').text( ($('#input_09').val()*w2050).toFixed(3));
	
	$('#27_2025').text( ($('#input_27').val()*w2025).toFixed(3));
	$('#27_2030').text( ($('#input_27').val()*w2030).toFixed(3));
	$('#27_2040').text( ($('#input_27').val()*w2040).toFixed(3));
	$('#27_2050').text( ($('#input_27').val()*w2050).toFixed(3));
	
	$('#16_2025').text( ($('#input_16').val()*w2025).toFixed(3));
	$('#16_2030').text( ($('#input_16').val()*w2030).toFixed(3));
	$('#16_2040').text( ($('#input_16').val()*w2040).toFixed(3));
	$('#16_2050').text( ($('#input_16').val()*w2050).toFixed(3));
	
	$('#06_2025').text( ($('#input_06').val()*w2025).toFixed(3));
	$('#06_2030').text( ($('#input_06').val()*w2030).toFixed(3));
	$('#06_2040').text( ($('#input_06').val()*w2040).toFixed(3));
	$('#06_2050').text( ($('#input_06').val()*w2050).toFixed(3));
	
	$('#99_2025').text( ($('#input_99').val()*w2025).toFixed(3));
	$('#99_2030').text( ($('#input_99').val()*w2030).toFixed(3));
	$('#99_2040').text( ($('#input_99').val()*w2040).toFixed(3));
	$('#99_2050').text( ($('#input_99').val()*w2050).toFixed(3));
	
	
}
 

function fn_init(){
	$.ajax({
		method : "POST",
		url : "/spec/getTotalAmtTarget.do",
		dataType : "json",
		async : false,
		success : function(result){
			var getTotalAmtTarget = result;
			var code_03 = getTotalAmtTarget.code_03;	
			var code_04 = getTotalAmtTarget.code_04
			var code_07 = getTotalAmtTarget.code_07;
			var code_14 = getTotalAmtTarget.code_14;
			var code_10 = getTotalAmtTarget.code_10;
			var code_11 = getTotalAmtTarget.code_11;
			var code_05 = getTotalAmtTarget.code_05;
			var code_20 = getTotalAmtTarget.code_20;
			var code_18 = getTotalAmtTarget.code_18;
			var code_15 = getTotalAmtTarget.code_15;
			var code_17 = getTotalAmtTarget.code_17;
			var code_19 = getTotalAmtTarget.code_19;
			var code_09 = getTotalAmtTarget.code_09;
			var code_27 = getTotalAmtTarget.code_27;
			var code_16 = getTotalAmtTarget.code_16;
			var code_06 = getTotalAmtTarget.code_06;
			var code_99 = getTotalAmtTarget.code_99;
			
			$('#input_03').val(code_03);
			$('#input_04').val(code_04);
			$('#input_07').val(code_07);
			$('#input_14').val(code_14);
			$('#input_10').val(code_10);
			$('#input_11').val(code_11);
			$('#input_05').val(code_05);
			$('#input_20').val(code_20);
			$('#input_18').val(code_18);
			$('#input_15').val(code_15);
			$('#input_17').val(code_17);
			$('#input_19').val(code_19);
			$('#input_09').val(code_09);
			$('#input_27').val(code_27);
			$('#input_16').val(code_16);
			$('#input_06').val(code_06);
			$('#input_99').val(code_99);
			
		},
		error : function(err) {
			alert("전송에 실패하였습니다 관리자 문의 바랍니다.");
		}
	});
}

function fn_save(){
	
	var input_03 = $('#input_03').val();
	var input_04 = $('#input_04').val();
	var input_07 = $('#input_17').val();
	var input_14 = $('#input_14').val();
	var input_10 = $('#input_10').val();
	var input_11 = $('#input_11').val();
	var input_05 = $('#input_05').val();
	var input_20 = $('#input_20').val();
	var input_18 = $('#input_18').val();
	var input_15 = $('#input_15').val();
	var input_17 = $('#input_17').val();
	var input_19 = $('#input_19').val();
	var input_09 = $('#input_09').val();
	var input_27 = $('#input_27').val();
	var input_16 = $('#input_16').val();
	var input_06 = $('#input_06').val();
	var input_99 = $('#input_99').val();
	
	$.ajax({
		method : "POST",
		url : "/spec/updtTotalAmtTarget.do",
	    data : {
	    	"code_03": input_03,
	    	"code_04": input_04,
	    	"code_07": input_07,
	    	"code_14": input_14,
	    	"code_10": input_10,
	    	"code_11": input_11,
	    	"code_05": input_05,
	    	"code_20": input_20,
	    	"code_18": input_18,
	    	"code_15": input_15,
	    	"code_17": input_17,
	    	"code_19": input_19,
	    	"code_09": input_09,
	    	"code_27": input_27,
	    	"code_16": input_16,
	    	"code_06": input_06,
	    	"code_99": input_99
	    },
		dataType : "json",
		async : false,
		success : function(result){
			alert('저장 완료');
		},
		error : function(err) {
			alert("전송에 실패하였습니다 관리자 문의 바랍니다.");
		}
	});
	
}


