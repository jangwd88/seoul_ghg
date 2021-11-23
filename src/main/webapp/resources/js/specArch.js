$(document).ready(function(){ 
	$('#loading').hide();
	init();
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

    $el.find('.btn-layerClose').click(function(){
        isDim ? $('.dim-layer').fadeOut() : $el.fadeOut(); // 닫기 버튼을 클릭하면
															// 레이어가 닫힌다.
        return false;
    });

    $('.layer .dimBg').click(function(){
        $('.dim-layer').fadeOut();
        return false;
    });

}

// /////건물명 검색 끝


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
	$("input[name=energySelect]:checked").each(function() {
//		console.log('온실가스 : ' + $(this).val());
	});
}

//건물용도 다중선택
function checkUseArch(chk) {
	var arch = document.getElementsByName("archSelect");
	for (var i = 0; i < arch.length; i++) {
		if (arch[i] != chk) {
			arch[i].checked = false;
		}
	}
	$("input[name=archSelect]:checked").each(function() {
//		console.log('건물용도 : ' + $(this).val());
	});
}

// 건물용도 전체 선택 및 전체 해제
function checkUseArchAll(){
	if($("#archUseAll").is(':checked')){
		$("input[name=archSelect]").prop("checked",true);
	} else {
		$("input[name=archSelect]").prop("checked",false);
	}
	$("input[name=archSelect]:checked").each(function() {
//		console.log('건물용도 : ' + $(this).val());
	});
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
			url : "/spec/listEmd.do",
		    data : {
		    	"admin_cd_sgg":admin_cd_sgg
		    },
			dataType : "json",
			async : false,
			success : function(result){
				$('#admin_cd_emd').empty();
				var listEmd = result;
				var optionHTML = '<option value="">선택</option>';
				for(i=0 ; i<listEmd.length ; i++){
					console.log(listEmd[i].admin_nm_emd);
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


function fnSelectEnergyTarget(){
	var energy_target  = $('#energy_target').val();
	if(energy_target == "target_first"){
		//건물 Str 삭제
		$('#cons_nm_str').text("전체");
		//건물 이름 배열 삭제
		arrConsNm = new Array();
		//테이블에 체크 된거 삭제
		$('#cons_all').prop('checked', false) ;
		$("#ConsTable > tbody").empty();
		
	} else {
		//건물 Str 삭제
		$('#cons_nm_str').text("전체");
		//건물 이름 배열 삭제
		arrConsNm = new Array();
		//테이블에 체크 된거 삭제
		$('#cons_all').prop('checked', false) ;
		$("#ConsTable > tbody").empty();
	}
}

function fnOpenSearchConsNm(){

	var energy_target  = $('#energy_target').val();
	
	$.ajax({
		method : "POST",
		url : "/spec/listCons.do",
	    data : {
			"energy_target":energy_target
	    },
		dataType : "json",
		async : false,
		success : function(result){

			var listCons = result;
			
			arrConsNm = new Array();
			
			$("#ConsTable > tbody").html();		
			
			var tr_html = "";
			
			for(i=0;i<listCons.length;i++){
				var cons_nm = listCons[i].cons_nm;
				var juso = listCons[i].juso;
				
				tr_html = tr_html + "<tr>";
				tr_html = tr_html + "<td>";
				tr_html = tr_html + "<input type='checkbox' value='";
				tr_html = tr_html + cons_nm;
				tr_html = tr_html + "' name='cons_nm''";	
				tr_html = tr_html + "</td>";
				tr_html = tr_html + "<td>";
				tr_html = tr_html + cons_nm;
				tr_html = tr_html + "</td>";
				tr_html = tr_html + "<td>";
				tr_html = tr_html + juso;
				tr_html = tr_html + "</td>";
				tr_html = tr_html + "</tr>";
				
			}
			
			$("#ConsTable > tbody:last").append(tr_html);
			
		},
		error : function(err) {
			alert("데이터 조회가 지연되고 있습니다. 잠시후 다시 확인 바랍니다.");
			$('#loading').hide();
			return false;
		}
	});
	
	
	
}

function fnConditionControl(flag){
	
	//all :전체
	//build : 건물명
	//officer : 관리부서
	//type : 건물용도
	
	//hidden 값 변경
	$("#conditionFlag").val(flag);
	
	if(flag == 'build'){
		arrOfficerNm = new Array();
		$('#officer_nm_str').text("전체");
		arrMainPurpsCd = new Array();
		$('#main_purps_nm_str').text("전체");
	} else if(flag == 'officer'){
		arrConsNm = new Array();
		$('#cons_nm_str').text("전체");
		arrMainPurpsCd = new Array();
		$('#main_purps_nm_str').text("전체");
	} else if(flag == 'type'){
		arrConsNm = new Array();
		$('#cons_nm_str').text("전체");
		arrOfficerNm = new Array();
		$('#officer_nm_str').text("전체");
	}
}

// 노후도 전체 선택 및 전체 해제
function search(){
	
	//필수 조건 에너지원
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
	
	if(energy_type_electric == 'N' && energy_type_gas == 'N' && energy_type_local == 'N'){
		alert("에너지원을 선택하세요.");
		return false;
	}
	
	var energy_target= $('#energy_target').val();
	
	var arr_condition = new Array();
	//all :전체
	//build : 건물명
	//officer : 관리부서
	//type : 건물용도
	
	var arr_main_purps_cd = arrMainPurpsCd;
	var arr_officer_nm = arrOfficerNm;
	var arr_cons_nm = arrConsNm;
	
	var conditionFlag = $('#conditionFlag').val();
	
	if(conditionFlag == 'all'){
		console.log('dont care');
	} else if(conditionFlag == 'build'){
		arr_condition = arr_cons_nm;
	} else if(conditionFlag == 'officer'){
		arr_condition = arr_officer_nm;
	} else if(conditionFlag == 'type'){
		arr_condition = arr_main_purps_cd;
	}
	
	$.ajax({
		method : "POST",
		url : "/spec/specArchList.do",
	    data : {
	    	"energy_type_electric":energy_type_electric,
	    	"energy_type_gas":energy_type_gas,
	    	"energy_type_local":energy_type_local,
	    	"energy_target":energy_target,
	    	"conditionFlag":conditionFlag,
			"arr_condition":arr_condition
	    },
		dataType : "html",
		async : true,
		beforeSend : function(xhr, opts) {
			$('#loading').show();
	    },
		success : function(result){
			$("#listResult").html("");
			$("#listResult").html(result);
			fnShowContLdregLayer();
			fnShowShp();
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
        	url: 'https://api.vworld.kr/req/wmts/1.0.0/BFF1C688-B3DE-3746-B364-004EE0DBC1C9/Base/{z}/{y}/{x}.png',
        })
      })
    ],
    view: new ol.View({
      center: [14135027.3,4518405.4],
      zoom: 17,
      minZoom : 10,
      maxZoom : 20
    }),
  logo:false
});

var tileLayer;
var tileSource;
var wmsSource;
var wmsAdminSource;

var tileLayer2;
var tileSource2;
var wmsSource2;

//shp 불러오기
function fnShowShp() {
	
	var energy_target= $('#energy_target').val();
	
	var arr_condition = new Array();
	//all :전체
	//build : 건물명
	//officer : 관리부서
	//type : 건물용도
	
	var arr_main_purps_cd = arrMainPurpsCd;
	var arr_officer_nm = arrOfficerNm;
	var arr_cons_nm = arrConsNm;
	
	var conditionFlag = $('#conditionFlag').val();
	
	if(conditionFlag == 'all'){
		console.log('dont care');
	} else if(conditionFlag == 'build'){
		console.log('건물명 배열 전달');
		arr_condition = arr_cons_nm;
		console.log(arr_condition);
	} else if(conditionFlag == 'officer'){
		console.log('관리부서 배열 전달');
		arr_condition = arr_officer_nm;
	} else if(conditionFlag == 'type'){
		console.log('건물용도 배열 전달');
		arr_condition = arr_main_purps_cd;
	}
	
	$.ajax({
		method : "POST",
		url : "/spec/listSpecArch.do",
	    data : {
	    	"energy_target":energy_target,
	    	"conditionFlag":conditionFlag,
			"arr_condition":arr_condition
	    },
		dataType : "json",
		async : false,
		success : function(result){
			
			var listSpecArch = result;
			var resultTableHtml = "";
			var init_x = 0;
			var init_y = 0;
			
			for(i=0;i<listSpecArch.length;i++){
				
				var target_num = listSpecArch[i].target_num;
	  			var gis_pk = listSpecArch[i].gis_pk;
	  			var mgm_bld_pk = listSpecArch[i].mgm_bld_pk;
	  			var cons_nm = listSpecArch[i].cons_nm;
	  			var juso = listSpecArch[i].juso;
	  			var sigungu_nm = listSpecArch[i].sigungu_nm;
	  			var bjdong_nm = listSpecArch[i].bjdong_nm;
	  			var totarea = listSpecArch[i].totarea;
	  			var main_purps_nm = listSpecArch[i].main_purps_nm;
	  			var main_purps_cd = listSpecArch[i].main_purps_cd;
	  			var prop_officer = listSpecArch[i].prop_officer;
	  			var useapr_day = listSpecArch[i].useapr_day;
	  			var x = 0;
	  			if(listSpecArch[i].x != null){
					x = listSpecArch[i].x;
					init_x = listSpecArch[i].x;
				}
	  			var y = 0;
	  			if(listSpecArch[i].y != null){
					y = listSpecArch[i].y;
					init_y = listSpecArch[i].y;
				}
	  			var allow_2025 = listSpecArch[i].allow_2025;
	  			var emiss_2025 = listSpecArch[i].emiss_2025;
	  			var reduc_2025 = listSpecArch[i].reduc_2025;
	  			
	  			resultTableHtml = resultTableHtml + "<tr>";
	  			
	  			resultTableHtml = resultTableHtml + "<td style='font-size: 75%;'>";
	  			resultTableHtml = resultTableHtml + (i+1);
	  			resultTableHtml = resultTableHtml + "</td>";
	  			
	  			resultTableHtml = resultTableHtml + "<td style='font-size: 75%;'>";
	  			resultTableHtml = resultTableHtml + mgm_bld_pk;
	  			resultTableHtml = resultTableHtml + "</td>";
	  			
	  			resultTableHtml = resultTableHtml + "<td style='font-size: 75%;'>";
	  			resultTableHtml = resultTableHtml + "<a href='#' onclick='javascript:fnMoveMap(" + x + "," + y + ",18);'>";
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
//			fnMoveMap(init_x, init_y, 18);
			
			$('#searchedBuildTable > tbody').html("");
			$('#searchedBuildTable > tbody').html(resultTableHtml);
			
			/* excelDownload variable */
			_successSearch = true;
			_excelFileNm = "총량제 대상 "+ $('#energy_target option:selected').text() +" 건축물 에너지 사용량 및 배출량 평가 도출내역";
			_excelDataSet = _copyList(result);
			
			
		},
		error : function(err) {
			alert("데이터 조회가 지연되고 있습니다. 잠시후 다시 확인 바랍니다.");
			$('#loading').hide();
			return false;
		}
	});
	
	
	if(energy_target == "target_first"){
		
		tileSource = new ol.source.TileWMS({
			url: 'http://210.113.102.190:9090/seoul/wms',
			params : {
				'LAYERS': 'seoul:seoul_target_1',
				'STYLES': 'seoul_target_style',
				'VERSION' : '1.1.1',
				'REQUEST' : 'GetMap'
			},
			serverType : 'geoserver',
			crossOrigin : 'anonymous'
		});

		tileLayer = new ol.layer.Tile({
			source: tileSource,
			layerId : 'seoul_target_1'
		});
		removePastLayer("seoul_target_1");
		removePastLayer("seoul_target_2");
		map.addLayer(tileLayer);
		
		
	} else if(energy_target == "target_second") {
		tileSource = new ol.source.TileWMS({
			url: 'http://210.113.102.190:9090/seoul/wms',
			params : {
				'LAYERS': 'seoul:seoul_target_2',
				'STYLES': 'seoul_target_style',
				'VERSION' : '1.1.1',
				'REQUEST' : 'GetMap'
			},
			serverType : 'geoserver',
			crossOrigin : 'anonymous'
		});

		tileLayer = new ol.layer.Tile({
			source: tileSource,
			layerId : 'seoul_target_2'
		});
		removePastLayer("seoul_target_1");
		removePastLayer("seoul_target_2");
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
	
}

map.on('singleclick', function(evt) {
	
	var coordinate = evt.coordinate //좌표 정보
    var view = map.getView();
    var viewResolution = view.getResolution();
    var viewProjection = view.getProjection();
    var source = wmsSource.getSource();
    
    var url = source.getGetFeatureInfoUrl(coordinate, viewResolution, viewProjection,
      {'INFO_FORMAT': 'application/json', 'FEATURE_COUNT': 50}
    );
    if (url) {
    	showWMSLayersInfoByCoordinate(url);
    }
    
    //지적 정보 불러오기
    var source2 = wmsSource2.getSource();
    var url2 = source2.getGetFeatureInfoUrl(coordinate, viewResolution, viewProjection,
       	{'INFO_FORMAT': 'application/json', 'FEATURE_COUNT': 50}
    );
    if (url2) {
    	showWMSLayersInfoByCoordinate2(url2);
    }
    
});


function showWMSLayersInfoByCoordinate(url) {
	
	var action_url = url.replace("I=", "X=").replace("J=", "Y=");;
	
	$.ajax({
		url : action_url,
		dataType : "json",
		success : function(data) {
			if(data.features.length > 0){
				var features = data.features;
				var feature = features[0];
				var geometry = feature.geometry;
				
				setHighlightFeature(geometry);
				getFeatureInfo(feature.properties.BD_PK_1);
				return;
			}
		},
		error : function(err) {
			alert("데이터 조회가 지연되고 있습니다. 잠시후 다시 확인 바랍니다.");
			$('#loading').hide();
			return false;
		}
   });
	
}

//선택된 feature 강조
function setHighlightFeature(geometry) {
	var source = new ol.source.Vector();
	
	var style = new ol.style.Style({
		stroke: new ol.style.Stroke({
			color : "#34eb46",
			width : 5
		}),
		Fill : new ol.style.Fill({
			color : "#FFFFFF"
		})
	
	});
	
	var feature = new ol.Feature();
	
	if(geometry.type =="MultiPolygon") {
		feature = new ol.Feature({
			geometry : new ol.geom.MultiPolygon(geometry.coordinates)
		});
	} else if (geometry.type =="Polygon") {
		feature = new ol.Feature({
			geometry : new ol.geom.Polygon(geometry.coordinates)
		});
	} else if (geometry.type =="Point") {
		feature = new ol.Feature({
			geometry : new ol.geom.Point(geometry.coordinates)
		});
		
		style = new ol.style.Style({
		      image: new ol.style.Circle({
		          radius: 10,
		          fill: new ol.style.Fill({color : "#FFFFFF"}),
		          stroke: new ol.style.Stroke({color : "#FF0000", width : 5})
		        })
		      });
	} else if (geometry.type =="MultiPoint") {
		feature = new ol.Feature({
			geometry : new ol.geom.MultiPoint(geometry.coordinates)
		});
		
		style = new ol.style.Style({
		      image: new ol.style.Circle({
		          radius: 10,
		          fill: new ol.style.Fill({color : "#FFFFFF"}),
		          stroke: new ol.style.Stroke({color : "#FF0000", width : 5})
		        })
		      });
	}
	
	feature.setStyle(style);
	source.addFeature(feature);
	
	var highlightLayer = new ol.layer.Vector({
		source: source,
		layerId : "highlight-layer",
		title : "선택된 레이어",
	});
	removePastLayer("highlight-layer");
	map.addLayer(highlightLayer);
	
}

function getFeatureInfo(bd_pk_1){
	
	if(bd_pk_1 == null || bd_pk_1 == ""){
		alert("수집된 데이터가 없습니다.");
	} else {
		fnViewBuildInfoByMgmBldPk(bd_pk_1);
	}
}

function fnViewBuildInfoByMgmBldPk(mgm_bld_pk){
	$.ajax({
		method : "POST",
		url : "/space/viewBuildInfoByMgmBldPk.do",
	    data : {
	    	"mgm_bld_pk":mgm_bld_pk
	    },
		dataType : "json",
		async : false,
		success : function(result){
			
			var viewBuildInfoByMgmBldPk = result;
			console.log(viewBuildInfoByMgmBldPk);
			if(viewBuildInfoByMgmBldPk == null){
				alert("수집된 데이터가 없습니다..");
			} else {
				
				var juso = viewBuildInfoByMgmBldPk.juso;
				var totarea = viewBuildInfoByMgmBldPk. totarea;
				var mgm_bld_pk = viewBuildInfoByMgmBldPk.mgm_bld_pk;
				var main_purps_nm = viewBuildInfoByMgmBldPk.main_purps_nm;
				var useapr_day = viewBuildInfoByMgmBldPk.useapr_day;
				
				$('#selected_bd_mgm_bld_pk').html(mgm_bld_pk);
				$('#selected_bd_juso').html(juso);
				$('#selected_bd_totarea').html(numberWithCommas(totarea));
				$('#selected_bd_main_purps_nm').html(main_purps_nm);
				$('#selected_bd_useapr_day').html(useapr_day);	
				
				$('#arch_totarea').val(totarea);
				
				$("#year").val("2020").attr("selected", "selected");
				$("#modalPop_002").modal('show');
				
				fnListBuildEnergyInfoByMonth(mgm_bld_pk, 2020);
				fnCheckUserLikeBuild(mgm_bld_pk);
				fnViewBuildByInfoMainPurpsNm(main_purps_nm);
			}
			
			
		},
		error : function(err) {
			alert("데이터 조회가 지연되고 있습니다. 잠시후 다시 확인 바랍니다.");
			$('#loading').hide();
			return false;
		}
	});
	
}


function fnViewBuildByInfoMainPurpsNm(main_purps_nm){
	
	var map = new Map();
	
	map.set("제1종근린생활시설","CODE_03");
	map.set("제2종근린생활시설","CODE_04");
	map.set("문화및집회시설","CODE_05");
	map.set("종교시설","CODE_06");
	map.set("판매시설","CODE_07");
	map.set("의료시설","CODE_09");
	map.set("교육연구시설","CODE_10");
	map.set("노유자시설","CODE_11");
	map.set("업무시설","CODE_14");
	map.set("숙박시설","CODE_15");
	map.set("위락시설","CODE_16");
	map.set("공장","CODE_17");
	map.set("창고시설","CODE_18");
	map.set("위험물 저장 및 처리시설","CODE_19");
	map.set("자동차 관련시설","CODE_20");
	map.set("관광 휴게시설","CODE_27");
	
	
	$.ajax({
		method : "POST",
		url : "/space/fnViewBuildByInfoMainPurpsNm.do",
		data : {
			"main_purps_code": map.get(main_purps_nm)
		},
		dataType : "json",
		async : false,
		success : function(data){
			
			// 기준년도 원단위
			var target  = data;
			// 연면적
			var totarea = parseFloat(($('#selected_bd_totarea').text()).replace(",",""));
			// 총 배출량
			var tco2eq= parseFloat(($('#tco2eq_t_all').text()).replace(",",""));
			// 원단위
			var oneUnit = tco2eq/totarea;
			// 목표
			var goal =0.2;
			// 허용 원단위 
			if(1-target/oneUnit >= goal*2){
			var al_oneUnit=	oneUnit*(1-goal*2);
			}else{
			var al_oneUnit =target;
			}
			// 총 배출허용량
			var al_totco2eq =al_oneUnit*totarea;
			// 감축률
			var reduction_rate = 1-(al_oneUnit/oneUnit);
			$('#selected_bd_total_amt_target').text(target);
			$('#selected_bd_allow_unit').text(al_oneUnit + "/" + (oneUnit).toFixed(2));
			$('#selected_bd_total_co2eq').text($('#tco2eq_t_all').text());
			$('#selected_bd_allow_total_co2eq').text(al_totco2eq.toFixed(2));
			$('#selected_bd_reduction_rate').text((reduction_rate*100).toFixed(2) + "%");
			
		},error : function(err){
			
		}
	});
}


function fnListBuildEnergyInfoByMonth(mgm_bld_pk, year){
	
	$.ajax({
		method : "POST",
		url : "/space/listBuildEnergyInfoByMonth.do",
	    data : {
	    	"mgm_bld_pk":mgm_bld_pk,
	    	"year":year
	    },
		dataType : "json",
		async : false,
		success : function(result){
			
			var listBuildEnergyInfoByMonth = result;
			
			var arrTco2eqT = new Array();
			var arrTco2eqTA = new Array();
			var arrTco2eqE = new Array();
			var arrTco2eqG = new Array();
			var arrTco2eqL = new Array();
			var arrEnergyUseE = new Array();
			var arrEnergyUseG = new Array();
			var arrEnergyUseL = new Array();
			
			//배열에 값 넣기
			for(i=0;i<listBuildEnergyInfoByMonth.length;i++){
				var buildEnergyInfoByMonth = listBuildEnergyInfoByMonth[i];
				
				var energy_type = buildEnergyInfoByMonth.energy_type;
				var month = buildEnergyInfoByMonth.month;
				var energy_use = buildEnergyInfoByMonth.energy_use;
				var tco2eq = buildEnergyInfoByMonth.tco2eq;
				
				if(energy_type == "전기"){
					arrTco2eqE.push(tco2eq);
					arrEnergyUseE.push(energy_use);
				} else if(energy_type == "가스"){
					arrTco2eqG.push(tco2eq);
					arrEnergyUseG.push(energy_use);
				} else if(energy_type == "지역난방"){
					arrTco2eqL.push(tco2eq);
					arrEnergyUseL.push(energy_use);
				}
			}
			
			//월별 온실가스총/단위면적당 온실가스/에너지/tco2 값 표출
			for(i=0;i<12;i++){
				
				var tco2eq_t = 0;
				var totarea = $('#arch_totarea').val();
				
				$('#tco2eq_e_' +  (i +1)).html("-");
	            $('#energy_use_e_' +  (i +1)).html("-");
	            $('#tco2eq_g_' +  (i +1)).html("-");
	            $('#energy_use_g_' +  (i +1)).html("-");
	            $('#tco2eq_l_' +  (i +1)).html("-");
	            $('#energy_use_l_' +  (i +1)).html("-");
	            $('#tco2eq_t_' +  (i +1)).html("-");
	            $('#tco2eq_t_area_' +  (i +1)).html("-");
	            
				if(arrTco2eqE[i] != null){
					$('#tco2eq_e_' +  (i +1)).html(numberWithCommas(Math.round(arrTco2eqE[i] * 100) / 100));
					$('#energy_use_e_' +  (i +1)).html(numberWithCommas(Math.round(arrEnergyUseE[i] * 100) / 100));
					tco2eq_t = tco2eq_t + arrTco2eqE[i];
				}
				
				if(arrTco2eqG[i] != null){
					$('#tco2eq_g_' +  (i +1)).html(numberWithCommas(Math.round(arrTco2eqG[i] * 100) / 100));
					$('#energy_use_g_' +  (i +1)).html(numberWithCommas(Math.round(arrEnergyUseG[i] * 100) / 100));
					tco2eq_t = tco2eq_t + arrTco2eqG[i];
				}
				
				if(arrTco2eqL[i] != null){
					$('#tco2eq_l_' +  (i +1)).html(numberWithCommas(Math.round(arrTco2eqL[i] * 100) / 100));
					$('#energy_use_l_' +  (i +1)).html(numberWithCommas(Math.round(arrEnergyUseL[i] * 100) / 100));
					tco2eq_t = tco2eq_t + arrTco2eqL[i];
				}

				
				$('#tco2eq_t_' +  (i +1)).html(numberWithCommas(Math.round(tco2eq_t * 100) / 100));
				$('#tco2eq_t_area_' +  (i +1)).html(numberWithCommas(Math.round(tco2eq_t/totarea * 100) / 100));
				
				arrTco2eqT.push(tco2eq_t);
				arrTco2eqTA.push(tco2eq_t/totarea);
				
			}
			
			//합계 부분
			var tco2eq_t = 0;
			var tco2eq_t_area_t = 0;
			var tco2eq_e_t = 0;
			var tco2eq_g_t = 0;
			var tco2eq_l_t = 0;
			var energy_use_e_t = 0;
			var energy_use_g_t = 0;
			var energy_use_l_t = 0;
			
			for(i=0;i<12;i++){
				if(arrTco2eqT[i] != null){
					tco2eq_t = tco2eq_t +arrTco2eqT[i];
				}
				if(arrTco2eqTA[i] != null){
					tco2eq_t_area_t = tco2eq_t_area_t + arrTco2eqTA[i];			
				}
				if(arrTco2eqE[i] != null){
					tco2eq_e_t = tco2eq_e_t + arrTco2eqE[i];
				}
				if(arrTco2eqG[i] != null){
					tco2eq_g_t = tco2eq_g_t + arrTco2eqG[i];
				}
				if(arrTco2eqL[i] != null){
					tco2eq_l_t = tco2eq_l_t + arrTco2eqL[i];
				}
				if(arrEnergyUseE[i] != null){
					energy_use_e_t = energy_use_e_t + arrEnergyUseE[i];
				}
				if(arrEnergyUseG[i] != null){
					energy_use_g_t = energy_use_g_t + arrEnergyUseG[i];
				}
				if(arrEnergyUseL[i] != null){
					energy_use_l_t = energy_use_l_t + arrEnergyUseL[i];
				}
				 
			}
			
			$('#tco2eq_t_all').html(numberWithCommas(Math.round(tco2eq_t * 100) / 100));
			$('#tco2eq_t_area_t').html(numberWithCommas(Math.round(tco2eq_t_area_t * 100) / 100));
			$('#tco2eq_e_t').html(numberWithCommas(Math.round(tco2eq_e_t * 100) / 100));
			$('#tco2eq_g_t').html(numberWithCommas(Math.round(tco2eq_g_t * 100) / 100));
			$('#tco2eq_l_t').html(numberWithCommas(Math.round(tco2eq_l_t * 100) / 100));
			$('#energy_use_e_t').html(numberWithCommas(Math.round(energy_use_e_t * 100) / 100));
			$('#energy_use_g_t').html(numberWithCommas(Math.round(energy_use_g_t * 100) / 100));
			$('#energy_use_l_t').html(numberWithCommas(Math.round(energy_use_l_t * 100) / 100));					
			
			

		},
		error : function(err) {
			alert("데이터 조회가 지연되고 있습니다. 잠시후 다시 확인 바랍니다.");
		}
	});
	
}

function numberWithCommas(x) {
	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); 
}

function fnSelectYear(){
	var year = $('#year').val();
	var mgm_bld_pk = $('#selected_bd_mgm_bld_pk').html();
	var main_purps_nm = $('#selected_bd_main_purps_nm').html();
	fnListBuildEnergyInfoByMonth(mgm_bld_pk, year);
	fnViewBuildByInfoMainPurpsNm(main_purps_nm);
	
	
	
}


// 관리부서
function checkLine(){
		if($("#officer_all").is(':checked') == true){
			$("input[name=officer_nm]").prop("checked",true);
		} else {
			$("input[name=officer_nm]").prop("checked",false);
		}
	}

function officerListSearch(){
	var officer_nm = $('#keyword').val();
	
	if(officer_nm.trim() == ""){
		alert("검색어를 입력해 주세요.");
		return;
	}
	
	jQuery.ajax({
		url : "/spec/specOfficerList.do",
		data : {
			officer_nm : officer_nm
		}
		, async : true
		, dataType : "json"
		, type : "POST"
		, beforeSend : function(xhr, opts) {
		}
		, error : function(request, status, error) {
		}
		, success : function(result) {	
			
			var listOfficer = result;
			var resultTableHtml ="";
			
			for(i=0;i<listOfficer.length;i++){
				resultTableHtml = resultTableHtml +"<tr><td><input type='checkbox' value='"+listOfficer[i].officer_nm+"' name='officer_nm' ></td>"+ "<td>"+listOfficer[i].officer_nm+"</td></tr>"
			}
			$('#searchedTable > tbody').html("");
			$('#searchedTable > tbody').html(resultTableHtml);
		}
		, complete : function() {
		}
		});
}	

var arrOfficerNm; 

function fnSelectOfficer(){
	arrOfficerNm = new Array();
	
	$("input:checkbox[name='officer_nm']").each(function(){
		if($(this).is(":checked") == true) {
				arrOfficerNm.push($(this).val());
		}
	});
	
	const set_nm = new Set(arrOfficerNm);
	const uniqueArr_nm = [...set_nm];
	
	var len = uniqueArr_nm.length;
	var officerNmStr ="";
	
	if(len == 0){
		officerNmStr = "전체";
	}else if(len == 1){
		officerNmStr = uniqueArr_nm[0];
	}else if(len > 1){
		officerNmStr = uniqueArr_nm[0] + " 외  " + (len-1) + " 건  ";
	}
	
	$('#officer_nm_str').text(officerNmStr);
	
	$('#officer_nm_modal').hide();	
	
	if(len > 0){
		fnConditionControl('officer');
	}
}


//건물용도 전체선택
function allArchLine(){
	if($("#arch_all").is(':checked') == true){
		$("input[name=main_purps_nm]").prop("checked",true);
	} else {
		$("input[name=main_purps_nm]").prop("checked",false);
	}
}

//건물 용도
var arrMainPurpsNm = new Array();
var arrMainPurpsCd = new Array();

function fnSelectMainPurps(){
	
	$("input:checkbox[name='main_purps_nm']").each(function(){
		if($(this).is(":checked") == true) {
			arrMainPurpsNm.push($(this).attr("value_nm"));
			arrMainPurpsCd.push($(this).val());
		}
	});

	const set_nm = new Set(arrMainPurpsNm);
	const uniqueArr_nm = [...set_nm];
	
	const set_cd = new Set(arrMainPurpsCd);
	const uniqueArr_cd = [...set_cd];
	
	var len = uniqueArr_nm.length;
	var main_purps_nm ="";

	if(len == 0){
		main_purps_nm = "전체";
	}else if(len == 1){
		main_purps_nm = uniqueArr_nm[0];
	}else if(len > 1){
		main_purps_nm = uniqueArr_nm[0] + " 외  " + (len-1) + " 건  ";
	}
	
	$("#main_purps_nm_str").text(main_purps_nm);
	
	$('#arch_type_modal').hide();
	
	if(len > 0){
		fnConditionControl('type');
	}
}

// 건물명
function checkConsLine(){
	if($("#cons_all").is(':checked') == true){
		$("input[name=cons_nm]").prop("checked",true);
	} else {
		$("input[name=cons_nm]").prop("checked",false);
	}
}

function consListSearch(){
	var cons_nm = $('#keyword_cons').val();
	
	if(cons_nm.trim() == ""){
		alert("검색어를 입력해 주세요.");
		return;
	}
	
	jQuery.ajax({
		url : "/spec/specConsList.do",
		data : {
			cons_nm : cons_nm
		}
		, async : true
		, dataType : "json"
		, type : "POST"
		, beforeSend : function(xhr, opts) {
		}
		, error : function(request, status, error) {
		}
		, success : function(result) {	
			
			var listCons = result;
			var resultTableHtml ="";
			
			for(i=0;i<listCons.length;i++){
				resultTableHtml = resultTableHtml +"<tr>" +
						"<td>" +
						"<input type='checkbox' value='"+listCons[i].cons_nm+"' name='cons_nm' >" +
						"</td>" +
					    "<td>" + listCons[i].cons_nm + "</td>" +
					    "<td>" + listCons[i].juso + "</td>" +
					    "</tr>";
			}
			$('#ConsTable > tbody').html("");
			$('#ConsTable > tbody').html(resultTableHtml);
		}
		, complete : function() {
		}
		});
}	
var arrConsNm; 

function fnSelectCons(){
	arrConsNm = new Array();
	
	$("input:checkbox[name='cons_nm']").each(function(){
		if($(this).is(":checked") == true) {
			arrConsNm.push($(this).val());
		}
	});
	
	const set_nm = new Set(arrConsNm);
	const uniqueArr_nm = [...set_nm];
	
	var len = uniqueArr_nm.length;
	var consNmStr ="";
	
	if (len == 0){
		consNmStr = "전체";
	}else if(len == 1){
		consNmStr = uniqueArr_nm[0];
	}else if(len > 1){
		consNmStr = uniqueArr_nm[0] +" 외  " + (len-1) + " 건  ";
	}
	
	$('#cons_nm_str').text(consNmStr);
	
	$('#cons_nm_modal').hide();	
	
	if(len > 0){
		fnConditionControl('build');
	}
}



function init(){
	/*  기본 이벤트 등록 : 검색 버튼 키다운*/
	$(".keyword_cons").keydown(function(e){
		var enterKeyCode = 13;
		
		var element = $(this);
		var elName = element.attr("name");
		if(e.keyCode == enterKeyCode){
			console.log(elName);
			switch(elName){
				case "keyword_cons":
					consListSearch();
					break;
				default:
				
			}
		}
	})
	
	$(".adrbtn").click(function(e){
		consListSearch();
	})
}


$(document).ready(function(){
	initOfficer();
});

function initOfficer(){
	/*  기본 이벤트 등록 : 검색 버튼 키다운*/
	$(".keyword").keydown(function(e){
		var enterKeyCode = 13;		
		var element = $(this);
		var elName = element.attr("name");
		if(e.keyCode == enterKeyCode){
			console.log(elName);
			switch(elName){
				case "keyword":
					officerListSearch();
					break;
				default:
				
			}
		}
	})
	
	$(".adrBtn1").click(function(e){
		officerListSearch();
	})
}

function fnMoveMap(x,y,level){
	if(x == 0 || y == 0){
		alert("위치정보가 없습니다.");
	} else {
		var pt =[x, y];
		map.getView().setCenter(pt);
		map.getView().setZoom(level);
		fnFeatureSelect(pt);
	}
}

function fnFeatureSelect(coord) {
	var coordinate = coord;
	var view = map.getView();
    var viewResolution = view.getResolution();
    var viewProjection = view.getProjection();
    var source = wmsSource.getSource();
    
    var url = source.getGetFeatureInfoUrl(coordinate, viewResolution, viewProjection,
      {'INFO_FORMAT': 'application/json', 'FEATURE_COUNT': 50}
    );
    if (url) {
    	showWMSLayersInfoByCoordinate3(url);
    }
    
    //지적 정보 불러오기
    var source2 = wmsSource2.getSource();
    var url2 = source2.getGetFeatureInfoUrl(coordinate, viewResolution, viewProjection,
       	{'INFO_FORMAT': 'application/json', 'FEATURE_COUNT': 50}
    );
    if (url2) {
    	showWMSLayersInfoByCoordinate2(url2);
    }
}

function showWMSLayersInfoByCoordinate2(url) {
	
	var action_url = url.replace("I=", "X=").replace("J=", "Y=");;
	$.ajax({
		url : action_url,
		dataType : "json",
		success : function(data) {
			if(data.features.length > 0){
				var features = data.features;
				var feature = features[0];
				var geometry = feature.geometry;
				setContLdregFeature(feature.properties.PNU);
				return;
			}
		},
		error : function(err) {
			console.log(err);
		}
   });
	
}

function showWMSLayersInfoByCoordinate3(url) {
	
	var action_url = url.replace("I=", "X=").replace("J=", "Y=");;
	
	$.ajax({
		url : action_url,
		dataType : "json",
		success : function(data) {
			if(data.features.length > 0){
				var features = data.features;
				var feature = features[0];
				var geometry = feature.geometry;
				
				setHighlightFeature(geometry);

				return;
			}
		},
		error : function(err) {
			console.log(err);
		}
   });
	
}

function fnShowContLdregLayer() {
	
	wmsSource2 = new ol.layer.Image({
        source: new ol.source.ImageWMS({
        ratio: 1,
          url: 'http://210.113.102.190:9090/seoul/wms',
          params: {
        	  'VERSION': '1.1.1',  
              'LAYERS': 'seoul:LSMD_CONT_LDREG',
          }
        })
	});
	
}

//선택된 feature 강조
function setContLdregFeature(pnu) {
	
	tileSource2 = new ol.source.TileWMS({
		url: 'http://210.113.102.190:9090/seoul/wms',
		params : {
			'LAYERS': 'seoul:LSMD_CONT_LDREG',
			'STYLES': 'seoul_admin_cont_ldreg_style',
			'CQL_FILTER' : 'PNU = ' + pnu,
			'VERSION' : '1.1.1',
			'REQUEST' : 'GetMap'
		},
		serverType : 'geoserver',
		crossOrigin : 'anonymous'
	});
	
	tileLayer2 = new ol.layer.Tile({
		source: tileSource2,
		layerId : 'LSMD_CONT_LDREG'
	});
	removePastLayer("LSMD_CONT_LDREG");
	map.addLayer(tileLayer2);
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