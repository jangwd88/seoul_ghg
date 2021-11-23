/**
 * required js 
 * 		sheetJS
 * 		filesaver
 * 		jquery
 */

/* Sheet JS 활용부분 */

var _successSearch = false; 
var _excelFileNm = null;
var _excelDataSet = null;

function _excelDownload(){
	var sheetName = "sheet";
	var fileName = null;
	var prefix = "";
	var suffix = ".xlsx";
	
	if(_excelFileNm!=null){
		fileName = _excelFileNm;
	}else{
		fileName = "온실가스 모니터링 시스템";
	}
	
	if(_excelDataSet!=null){
		var _excelConvertDataList = new Array();
		for(var i=0; i<_excelDataSet.length; i++){
			var obj = _excelDataSet[i];
			var o = new Object();

			var consNm = obj.cons_nm != null && obj.cons_nm != '' ? obj.cons_nm : '-';
			var address = obj.juso != null && obj.juso != '' ? obj.juso : '-';
			
			o["순번"]=(i+1);
			o["건축물 관리번호"]=obj.mgm_bld_pk;	
			o["건물명"]=consNm;
			o["주소"]=address;	
			o["준공연도"]=obj.useapr_day;
			o["연면적(m2)"]=obj.totarea;
			
			_excelConvertDataList.push(o);
		}
		
		var excelHandler = {
				getExcelFileName : function(){
				    return prefix+fileName+suffix;
				},
				getSheetName : function(){
					return sheetName;
				},
				getExcelData : function(){
					return _excelConvertDataList;
				},
				getWorksheet : function(){
					return XLSX.utils.json_to_sheet(this.getExcelData());
				}
			};
		
		var wb = XLSX.utils.book_new();
	    var newWorksheet = excelHandler.getWorksheet();
	    XLSX.utils.book_append_sheet(wb, newWorksheet, excelHandler.getSheetName());
	    var wbout = XLSX.write(wb, {bookType:'xlsx',  type: 'binary'});
	   
	    saveAs(new Blob([_s2ab(wbout)],{type:"application/octet-stream"}), excelHandler.getExcelFileName());
	}else{
		alert("조회된 데이터가 없습니다.")
	}
}

function _copyList(array){
	var newArray = new Array();
	if(array!=null){
		for(var i=0; i<array.length; i++){
			var item = array[i];
			var obj = new Object();
			for(var key in item){
				obj[key] = item[key];
			}
			newArray.push(obj);
		}
	}else{
		console.log("array is null!!!");
	}
	return newArray;
}

function _s2ab(s) { 
    var buf = new ArrayBuffer(s.length); //convert s to arrayBuffer
    var view = new Uint8Array(buf);  //create uint8array as viewer
    for (var i=0; i<s.length; i++) view[i] = s.charCodeAt(i) & 0xFF; //convert to octet
    return buf;    
}

/* SheetJS 활용 부분 끝*/
