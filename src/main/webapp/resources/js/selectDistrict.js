$(document).ready(function(){ 
	$('#loading').hide();
});

// 건물명 검색
$('.btn-example').click(function(){
    var $href = $(this).attr('href');
    layer_popup($href);
});
function layer_popup(el){

    var $el = $(el);        // 레이어의 id를 $el 변수에 저장
    var isDim = $el.prev().hasClass('dimBg');   // dimmed 레이어를 감지하기 위한
												// boolean 변수

    isDim ? $('.dim-layer').fadeIn() : $el.fadeIn();

    var $elWidth = ~~($el.outerWidth()),
        $elHeight = ~~($el.outerHeight()),
        docWidth = $(document).width(),
        docHeight = $(document).height();

    // 화면의 중앙에 레이어를 띄운다.
    if ($elHeight < docHeight || $elWidth < docWidth) {
        $el.css({
            marginTop: -$elHeight /2,
            marginLeft: -$elWidth/2
        })
    } else {
        $el.css({top: 0, left: 0});
    }

    $el.find('a.btn-layerClose').click(function(){
        isDim ? $('.dim-layer').fadeOut() : $el.fadeOut(); // 닫기 버튼을 클릭하면
															// 레이어가 닫힌다.
        return false;
    });

    $('.layer .dimBg').click(function(){
        $('.dim-layer').fadeOut();
        return false;
    });

}


// 온실가스 전체 선택 및 전체 해제
function checkAllEnergy(){
	if($("#energyCheckAll").is(':checked')){
		$("input[name=energySelect_E]").prop("checked",true);
		$("input[name=energySelect_G]").prop("checked",true);
		$("input[name=energySelect_L]").prop("checked",true);
	} else {
		$("input[name=energySelect_E]").prop("checked",false);
		$("input[name=energySelect_G]").prop("checked",false);
		$("input[name=energySelect_L]").prop("checked",false);
	}
}

function fnSelectSgg(){
	
	var admin_cd_sgg = $('#admin_cd_sgg').val();
	var admin_nm_sgg = $("#admin_cd_sgg option:checked").text();
	$('#sigungu_nm').val(admin_nm_sgg);
	
	if(admin_cd_sgg == null || admin_cd_sgg == ""){		
		return false;
	} else {
		$.ajax({
			method : "POST",
			url : "/space/listEmd.do",
		    data : {
		    	"admin_cd_sgg":admin_cd_sgg
		    },
			dataType : "json",
			async : false,
			success : function(result){
				$('#admin_cd_emd').empty();
				var listEmd = result;
				var optionHTML = '<option value="all">전체</option>';
				for(i=0 ; i<listEmd.length ; i++){
					var admin_cd_emd = listEmd[i].admin_cd_emd;
					var admin_nm_emd = listEmd[i].admin_nm_emd;
					optionHTML += '<option value="'+ admin_cd_emd +'" ';
					optionHTML += '>' + admin_nm_emd +'</option>'
				}
				$('#admin_cd_emd').append(optionHTML);
			},
			error : function(err) {
				alert("전송에 실패하였습니다 관리자 문의 바랍니다.");
			}
		});
	}	
}

function fnSelectEmd(){
	
	var admin_cd_emd = $('#admin_cd_emd').val();
	var admin_nm_emd = $("#admin_cd_emd option:checked").text();
	$('#bjdong_nm').val(admin_nm_emd);
	
}

var arrMainPurpsNm = new Array();
var arrMainPurpsCd = new Array();

function fnSelectMainPurps(){
	
	var main_purps_nm = $("#main_purps_cd option:checked").text();
	var main_purps_cd = $("#main_purps_cd").val();

	arrMainPurpsNm.push(main_purps_nm);
	arrMainPurpsCd.push(main_purps_cd);
	
	$("#arr_main_purps_nm").val(arrMainPurpsNm);
	
}

// 노후도 전체 선택 및 전체 해제
function search(){
	
	var energy_type_electric = 'N';
	var energy_type_gas = 'N';
	var energy_type_local = 'N';
	
	if($("#energySelect_E").is(':checked')){
		energy_type_electric = 'Y';
	}
	if($("#energySelect_G").is(':checked')){
		energy_type_gas = 'Y';
	}
	if($("#energySelect_L").is(':checked')){
		energy_type_local = 'Y';
	}
	
	var arr_main_purps_cd = arrMainPurpsCd;
	
	var age_ratio = $('#age_ratio').val();
	var tot_area = $('#tot_area').val();
	
	var si = $('#si').val();
	var sigungu_nm = $('#sigungu_nm').val();
	var bjdong_nm = $('#bjdong_nm').val();
	var admin_cd_sgg = $('#admin_cd_sgg').val();
	var admin_cd_emd = $('#admin_cd_emd').val();
	
	var start_year = $('#start_year').val();
	var start_month = $('#start_month').val();
	var end_year = $('#end_year').val();
	var end_month = $('#end_month').val();
	
	if(energy_type_electric == 'N' && energy_type_gas == 'N' && energy_type_local == 'N'){
		alert("에너지원을 선택해주세요");
		return false;
	}
	
	if(! sigungu_nm){
		alert("검색할 구를 선택해주세요");
		$("#sigungu_nm").focus();
		return false;
	}

	if(! bjdong_nm){
		alert("검색할 동을 선택해주세요");
		$("#bjdong_nm").focus();
			return false;
	}
	
	if(! admin_cd_sgg){
		alert("검색할 구를 선택해주세요");
		$("#admin_cd_sgg").focus();
			return false;
	}
	
	if(! admin_cd_emd){
		alert("검색할 동을 선택해주세요");
		$("#admin_cd_emd").focus();
			return false;
	}

	$.ajax({
		method : "POST",
		url : "/space/selectDistrictList.do",
	    data : {
	    	"energy_type_electric":energy_type_electric,
	    	"energy_type_gas":energy_type_gas,
	    	"energy_type_local":energy_type_local,
	    	"arr_main_purps_cd":arr_main_purps_cd,
	    	"age_ratio":age_ratio,
	    	"tot_area":tot_area,
	    	"si":si,
	    	"sigungu_nm":sigungu_nm,
	    	"bjdong_nm":bjdong_nm,
	    	"admin_cd_sgg":admin_cd_sgg,
	    	"admin_cd_emd":admin_cd_emd,
	    	"start_year":start_year,
	    	"start_month":start_month,
	    	"end_year":end_year,
	    	"end_month":end_month
	    },
		dataType : "html",
		async : true,
		beforeSend : function(xhr, opts) {
			$('#loading').show();
	    },
		success : function(result){
			$("#listResult").html("");
			$("#listResult").html(result);
			fnShowShp();
			fnListbuild();
			$('#loading').hide();
		},
		error : function(err) {
			alert("데이터 조회가 지연되고 있습니다. 잠시후 다시 확인 바랍니다.");
			$('#loading').hide();
			return false;
		}
	});
	
}


//map Center설정
var map = new ol.Map({
    target: 'map',
    layers: [
    	new ol.layer.Tile({
            source: new ol.source.XYZ({
            	url: 'https://api.vworld.kr/req/wmts/1.0.0/BFF1C688-B3DE-3746-B364-004EE0DBC1C9/Base/{z}/{y}/{x}.png'
            })
          })
    ],
    view: new ol.View({
    	center: [14135027.3,4518405.4],
		zoom: 17,
		minZoom : 10,
		maxZoom : 19
    }),
    logo:false
});



var tileLayer;
var tileSource;
var wmsSource;
var wmsAdminSource;

//shp 불러오기
function fnShowShp() {
	var admin_cd_sgg = $('#admin_cd_sgg').val();
	var admin_cd_emd = $('#admin_cd_emd').val();//10단위
	var sig_cd = admin_cd_emd.substr(0,5);
	var emd_cd = admin_cd_emd.substr(5,3);
	var li_cd = admin_cd_emd.substr(8,2);
	
	var sigungu_nm = $('#sigungu_nm').val();
	var bjdong_nm = $('#bjdong_nm').val();

	console.log(admin_cd_sgg);
	console.log(admin_cd_emd);
	console.log(sig_cd);
	console.log(emd_cd);
	console.log(li_cd);
	
	var range = "emd";
	var admin_code = bjdong_nm;
	if(bjdong_nm == "전체"){
		range = "sgg";
		admin_code = admin_cd_sgg;
	}
	
	$.ajax({
		method : "POST",
		url : "/space/getAdminCoord.do",
	    data : {
	    	"range": range,
	    	"admin_code":admin_code
	    },
		dataType : "json",
		async : false,
		success : function(result){
			
			var getAdminCoord = result;
			
			var pt = [getAdminCoord.x, getAdminCoord.y];

			//해당지역으로 이동
			map.getView().setCenter(pt);
			map.getView().setZoom(11);
						
			var filter_emd = 'BDTYP_CD_2 IN ('+ arrMainPurpsCd +') AND SIG_CD = ' + sig_cd + ' AND EMD_CD = ' + emd_cd + ' AND LI_CD = ' + li_cd;
			var filter_sgg = 'BDTYP_CD_2 IN ('+ arrMainPurpsCd +') AND SIG_CD = ' + sig_cd;
			var filter_admin_emd = 'EMD_CD = ' + admin_cd_emd.substr(0,8);
			var filter_admin_sgg = 'SIG_CD = ' + admin_cd_sgg;
			
			if(bjdong_nm == '전체'){
				wmsAdminSource = new ol.layer.Image({
			        source: new ol.source.ImageWMS({
			        ratio: 1,
			        url: 'http://210.113.102.190:9090/seoul/wms',
			        params: {
			        		'VERSION': '1.1.1', 
			        		'STYLES': 'seoul_admin_style',
			        		'LAYERS': 'seoul:TL_SCCO_SIG_SEOUL',
			        		'CQL_FILTER' : filter_admin_sgg,
			                'exceptions': 'application/vnd.ogc.se_inimage'
			        	}
			        }),
			        layerId : 'layer_admin'
				});
				removePastLayer("layer_admin");
				map.addLayer(wmsAdminSource);
				
				tileSource = new ol.source.TileWMS({
					url: 'http://210.113.102.190:9090/seoul/wms',
					params : {
						'LAYERS': 'seoul:TL_SPBD_BULD',
						'STYLES': 'seoul_buld_style',
						'VERSION' : '1.1.1',
						'CQL_FILTER' : filter_emd,
						'REQUEST' : 'GetMap'
					},
					serverType : 'geoserver',
					crossOrigin : 'anonymous'
				});
		
				tileLayer = new ol.layer.Tile({
					source: tileSource,
					layerId : 'TL_SPBD_BULD'
				});
				removePastLayer("TL_SPBD_BULD");
				map.addLayer(tileLayer);
				
			} else {
				wmsAdminSource = new ol.layer.Image({
			        source: new ol.source.ImageWMS({
			        ratio: 1,
			        url: 'http://210.113.102.190:9090/seoul/wms',
			        params: {
			        		'VERSION': '1.1.1',  
			        		'STYLES': 'seoul_admin_style',
			        		'LAYERS': 'seoul:LSMD_ADM_SECT_UMD',
			                'CQL_FILTER' : filter_admin_emd,
			                'exceptions': 'application/vnd.ogc.se_inimage'
			        	}
			        }),
			        layerId : 'layer_admin'
				});
				removePastLayer("layer_admin");
				map.addLayer(wmsAdminSource);
				
				tileSource = new ol.source.TileWMS({
					url: 'http://210.113.102.190:9090/seoul/wms',
					params : {
						'LAYERS': 'seoul:TL_SPBD_BULD',
						'STYLES': 'seoul_buld_style',
						'VERSION' : '1.1.1',
						'CQL_FILTER' : filter_sgg,
						'REQUEST' : 'GetMap'
					},
					serverType : 'geoserver',
					crossOrigin : 'anonymous'
				});
		
				tileLayer = new ol.layer.Tile({
					source: tileSource,
					layerId : 'TL_SPBD_BULD'
				});
				removePastLayer("TL_SPBD_BULD");
				map.addLayer(tileLayer);
			}
				
			wmsSource = new ol.layer.Image({
		        source: new ol.source.ImageWMS({
		        ratio: 1,
		        url: 'http://210.113.102.190:9090/seoul/wms',
		        params: {
		        	  'VERSION': '1.1.1',  
		              'LAYERS': 'seoul:TL_SPBD_BULD',
		        	}
		        })
			});
			
			$('#legend').show();
			
		},
		error : function(err) {
			console.log(err);
		}
	});
	
	
}

function fnListbuild(){
	var arr_main_purps_cd = arrMainPurpsCd;
	
	var sigungu_nm = $('#sigungu_nm').val();
	var bjdong_nm = $('#bjdong_nm').val();
	
	$.ajax({
		method : "POST",
		url : "/space/listArch.do",
	    data : {
	    	"start_age_ratio":"",
			"end_age_ratio":"",
			"start_tot_area": "",
			"end_tot_area":"",
	    	"sigungu_nm":sigungu_nm,
	    	"bjdong_nm":bjdong_nm
	    },
		dataType : "json",
		async : false,
		success : function(result){
			
			var listArch = result;
			var resultTableHtml = "";
			var init_x = 0;
			var init_y = 0;
			
			for(i=0;i<listArch.length;i++){
				
	  			var mgm_bld_pk = listArch[i].mgm_bld_pk;
				var sigungu_nm = listArch[i].sigungu_nm;
				var bjdong_nm = listArch[i].bjdong_nm;
				var main_purps_nm = listArch[i].main_purps_nm;
				var main_purps_cd = listArch[i].main_purps_cd;
				var juso = listArch[i].juso;
				var cons_nm = "-";
				if(listArch[i].cons_nm != null){
					cons_nm = listArch[i].cons_nm;
				}
	  			var totarea = listArch[i].totarea;
	  			var useapr_day = listArch[i].useapr_day;
	  			var x = 0;
	  			if(listArch[i].x != null){
					x = listArch[i].x;
					init_x = listArch[i].x;
				}
	  			var y = 0;
	  			if(listArch[i].y != null){
					y = listArch[i].y;
					init_y = listArch[i].y;
				}
	  			
	  			resultTableHtml = resultTableHtml + "<tr>";
	  			
	  			resultTableHtml = resultTableHtml + "<td style='font-size: 75%; padding: 1px;'>";
	  			resultTableHtml = resultTableHtml + (i+1);
	  			resultTableHtml = resultTableHtml + "</td>";
	  			
	  			resultTableHtml = resultTableHtml + "<td style='font-size: 75%;'>";
	  			resultTableHtml = resultTableHtml + mgm_bld_pk;
	  			resultTableHtml = resultTableHtml + "</td>";
	  			
	  			resultTableHtml = resultTableHtml + "<td style='font-size: 75%;'>";
	  			resultTableHtml = resultTableHtml + "<a href='#' onclick='javascript:fnMoveMap(" + x + "," + y + ", 18);'>";
	  			resultTableHtml = resultTableHtml + cons_nm;
	  			resultTableHtml = resultTableHtml + "</a>";
	  			resultTableHtml = resultTableHtml + "</td>";
	  			
	  			resultTableHtml = resultTableHtml + "<td style='font-size: 75%;'>";
	  			resultTableHtml = resultTableHtml + juso;
	  			resultTableHtml = resultTableHtml + "</td>";
	  			
	  			resultTableHtml = resultTableHtml + "<td style='font-size: 75%;'>";
	  			resultTableHtml = resultTableHtml + useapr_day;
	  			resultTableHtml = resultTableHtml + "</td>";
	  			
	  			resultTableHtml = resultTableHtml + "<td style='font-size: 75%;'>";
	  			resultTableHtml = resultTableHtml + numberWithCommas(totarea);
	  			resultTableHtml = resultTableHtml + "</td>";
	  			
	  			resultTableHtml = resultTableHtml + "</tr>";
				
			}
			
			//지도 이동
			fnMoveMap(init_x, init_y, 12);
			
			$('#searchedBuildTable > tbody').html("");
			$('#searchedBuildTable > tbody').html(resultTableHtml);
			
			/* excelDownload variable */
			_successSearch = true;
			_excelFileNm =  sigungu_nm + " " + bjdong_nm +" 건축물별 에너지 사용량 및 배출량 평가 도출내역";
			_excelDataSet = _copyList(result);
			
		},
		error : function(err) {
			alert("데이터 조회가 지연되고 있습니다. 잠시후 다시 확인 바랍니다.");
			$('#loading').hide();
			return false;
		}
	});
}

function fnMoveMap(x,y,level){
	if(x == 0 || y == 0){
		alert("위치정보가 없습니다.");
	} else {
		var pt =[x, y];
		map.getView().setCenter(pt);
		map.getView().setZoom(level);
	}
}

//레이어 삭제
function removePastLayer(layerId) {
	var layers = map.getLayers();

	layers.forEach(function (layer, i){
		if(typeof layer == "undefined") {
			return;
		}

		if(layer.get("layerId") == layerId) {
			map.removeLayer(layer);
		}
	});
}