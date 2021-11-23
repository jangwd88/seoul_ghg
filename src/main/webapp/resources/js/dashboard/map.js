/* 전역 변수 선언 */
var map;
var tileLayer;
var tileSource;
var wmsSource;
var wmsAdminSource;

var geoserverUrl = 'http://210.113.102.190:9090/geoserver';
var workspace = '/seoul';

//map.getView().calculateExtent(map.getSize())
var _defaultExt = [14095768.390643941, 4496985.939537316, 14180679.591208665, 4540225.252364672];

/* 문서 준비 완료 */
$(document).ready(function() {
	initMap();
	loadAllOverlay();
});

function initMap(){
	/* 맵 선언 */
	map = new ol.Map({
		    target : 'map',
		layers : [ new ol.layer.Tile(
				{
					source : new ol.source.XYZ(
							{
								url : 'https://api.vworld.kr/req/wmts/1.0.0/BFF1C688-B3DE-3746-B364-004EE0DBC1C9/Base/{z}/{y}/{x}.png',
							})
				}) ],
		view : new ol.View({
			center : [ 14135027.3, 4518405.4 ],
			minZoom : 11.5,
			maxZoom : 20
		}),
		logo : false
	});
	
	map.getView().fit( _defaultExt, map.getSize() );
	
	fnShowShp();
	
}


//shp 불러오기
function fnShowShp() {
			
	wmsAdminSource = new ol.layer.Image({
        source: new ol.source.ImageWMS({
        ratio: 1,
        url: geoserverUrl+workspace+'/wms',
        params: {
        		'VERSION': '1.1.1',  
        		'STYLES': 'seoul_admin_style',
                'LAYERS': 'seoul:LSMD_ADM_SECT_UMD',
        	}
        })
	});
	map.addLayer(wmsAdminSource);

	
	tileSource = new ol.source.TileWMS({
		url: geoserverUrl+workspace+'/wms',
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

	map.addLayer(tileLayer);
			
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
}


/* made by hhh */
function loadAllOverlay(){

	var _div = $("<div></div>");
	var _span = $("<span></span>");
	
	var url = '/dash/spec/seoul/own/target/1.do';
	$.ajax({
		url : url,
		dataType : "json",
		success : function(list) {
			/*모든 팝업 삭제*/
			$("#popupArea").empty();
			
			/*단위*/
			var unit = ' tCO₂';
			
			for(var i=0; i<list.length; i++){
				var o = list[i];
			
				//var container = _div.clone().addClass("ol-popup-custom popup");
				/*
				var popupWhole = _div.clone();
				var row = _div.clone().addClass("popup-row");
				var th = _div.clone().addClass("popup-th col-6 text-center");
				var td = _div.clone().addClass("popup-td col-6 text-center");
				
				th.append(_span.clone().text("'25년 배출총량"));
				var emissVal = null;
				if(o.emiss_2025!=null){
					emissVal = numberWithCommas(o.emiss_2025) + unit;
				}else{
					emissVal = '-'
				}
				td.append(_span.clone().text(emissVal));
				
				row.append(th);
				row.append(td);
				
				th = _div.clone().addClass("popup-th col-6 text-center");
				td = _div.clone().addClass("popup-td col-6 text-center");
				
				th.append(_span.clone().text("'20년 배출현황"));
				if(o.emiss_2020!=null){
					emissVal = numberWithCommas(o.emiss_2020) + unit;
				}else{
					emissVal = '-'
				}
				td.append(_span.clone().text(emissVal));
				row.append(th);
				row.append(td);

				popupWhole.append(row);
				
				
				var content = popupWhole.html();
				
				*/
				
				var overlay = new ol.Overlay({
			        element: _div.clone()[0]
			      });

				var coord = [o.x,o.y];
				map.addOverlay(overlay);
				overlay.setPosition(coord);
				
				var element = overlay.getElement();
				$(element).popover({
					container: element
				    , placement: 'top'
				    , html: true
				    , offset:'0, 4'
				    , title: o.cons_nm
				    , trigger: 'manual'
				    //, content: content
				}).parent().attr("data-id", o.mgm_bld_pk)
				.on({
					mouseenter: function () { $(this).css("z-index",1000); },
					mouseleave: function () { $(this).css("z-index",100); },
					click : function () { popoverClick($(this)) },
				}).css("z-index",100);
				
				$(element).popover('show');
				
				
			}
		}
	});
}

function popoverClick(obj){
	
	var mgm_bld_pk = obj.attr("data-id");
	
	fnViewBuildInfoByMgmBldPk(mgm_bld_pk);
}

//클릭이벤트 제거
//map.on('singleclick', function(evt) {
//	
//	var coordinate = evt.coordinate //좌표 정보
//    var view = map.getView();
//    var viewResolution = view.getResolution();
//    var viewProjection = view.getProjection();
//    var source = wmsSource.getSource();
//    
//    var url = source.getGetFeatureInfoUrl(coordinate, viewResolution, viewProjection,
//      {'INFO_FORMAT': 'application/json', 'FEATURE_COUNT': 50}
//    );
//    if (url) {
//    	showWMSLayersInfoByCoordinate(url);
//    }
//    
//});


function showWMSLayersInfoByCoordinate(url) {
	
	var action_url = url.replace("I=", "X=").replace("J=", "Y=");;
	console.log(action_url);
	$.ajax({
		url : action_url,
		dataType : "json",
		success : function(data) {
			console.log(data);
			if(data.features.length > 0){
				var features = data.features;
				console.log(features);
				var feature = features[0];
				console.log(feature);
				var geometry = feature.geometry;
				console.log(feature.properties.BD_PK_1);
				setHighlightFeature(geometry);
				getFeatureInfo(feature.properties.BD_PK_1);

				return;
			}
		},
		error : function(err) {
			console.log(err);
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
		console.log(geometry.coordinates[0]);
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
	
	map.addLayer(highlightLayer);
	
}

function getFeatureInfo(bd_pk_1){
	
	var energy_type_electric = 'Y';
	var energy_type_gas = 'Y';
	var energy_type_local = 'Y';
	var start_year = '2020';
	var start_month = '01';
	var end_year = '2020';
	var end_month = '12';
	
	$.ajax({
		method : "POST",
		url : "/space/viewBuildInfo.do",
	    data : {
	    	"bd_pk_1":bd_pk_1,
	    	"start_year":start_year,
	    	"start_month":start_month,
	    	"end_year":end_year,
	    	"end_month":end_month,
	    	"energy_type_electric":energy_type_electric,
	    	"energy_type_gas":energy_type_gas,
	    	"energy_type_local":energy_type_local
	    },
		dataType : "json",
		async : false,
		success : function(result){
			
			var listBuildInfo = result; 
			
			for(i=0;i<listBuildInfo.length;i++){
				var buildInfo = listBuildInfo[i];
				
				$("#selected_bd_mgm_bld_pk").html(buildInfo.mgm_bld_pk);
				$("#selected_bd_juso").html(buildInfo.juso);
				$("#selected_bd_totarea").html(buildInfo.totarea);
				$("#selected_bd_useapr_day").html(buildInfo.useapr_day);
				
				var energy_type = buildInfo.energy_type;
				if(energy_type == '전기'){
					$("#selected_bd_tco2eq_e").html(buildInfo.tco2eq);
					$("#selected_bd_energy_use_e").html(buildInfo.energy_use);
				}else if(energy_type == '가스'){
					$("#selected_bd_tco2eq_g").html(buildInfo.tco2eq);
					$("#selected_bd_energy_use_g").html(buildInfo.energy_use);
				}else if(energy_type == '지역난방'){
					$("#selected_bd_tco2eq_l").html(buildInfo.tco2eq);
					$("#selected_bd_energy_use_l").html(buildInfo.energy_use);
				}
			} 
			
		},
		error : function(err) {
//			alert("전송에 실패하였습니다 관리자 문의 바랍니다.");
		}
	});
	$("#year").val("2020").attr("selected", "selected");
	$("#modalPop_002").modal('show');
}


function fnNextViewSeoulOwnTarget1(){
	
	$.ajax({
		method : "POST",
		url : "/dash/nextViewSeoulOwnTarget1.do",
	    data : {
	    },
		dataType : "json",
		async : false,
		success : function(result){
			var nextViewSeoulOwnTarget1 = result; 
			var target_num = nextViewSeoulOwnTarget1.target_num;
			fnViewBuildInfo(target_num);
		},
		error : function(err) {
//			alert("전송에 실패하였습니다 관리자 문의 바랍니다.");
		}
	});
	
}

function fnViewBuildInfo(target_num){
	
	$.ajax({
		method : "POST",
		url : "/dash/viewSeoulOwnTarget1.do",
	    data : {
	    	"target_num":target_num
	    },
		dataType : "json",
		async : false,
		success : function(result){
			
			var viewSeoulOwnTarget1 = result; 
			
			var bjdong_nm = viewSeoulOwnTarget1.bjdong_nm;
			var	cons_nm = viewSeoulOwnTarget1.cons_nm;
			var	gis_pk = viewSeoulOwnTarget1.gis_pk;
			var	juso = viewSeoulOwnTarget1.juso;
			var	main_purps_cd = viewSeoulOwnTarget1.main_purps_cd;
			var	main_purps_nm = viewSeoulOwnTarget1.main_purps_nm;
			var	mgm_bld_pk = viewSeoulOwnTarget1.mgm_bld_pk;
			var	prop_officer = viewSeoulOwnTarget1.prop_officer;
			var	sigungu_nm = viewSeoulOwnTarget1.sigungu_nm;
			var	target_num = viewSeoulOwnTarget1.target_num;
			var	totarea = viewSeoulOwnTarget1.totarea;
			var useapr_day = viewSeoulOwnTarget1.useapr_day;
			var allow_2025 = viewSeoulOwnTarget1.allow_2025;
			var emiss_2025 = viewSeoulOwnTarget1.emiss_2025;
			var reduc_2025 = viewSeoulOwnTarget1.reduc_2025;
			var x = viewSeoulOwnTarget1.x;
			var y = viewSeoulOwnTarget1.y;
			
			//지도 이동
			var pt =[x, y];
			map.getView().setCenter(pt);
			map.getView().setZoom(18);
			
			//건물 정보 변경
			$("#cons_nm").text(cons_nm);
			$("#juso").text(juso);
			$("#prop_officer").text(prop_officer);
			$("#main_purps_nm").text(main_purps_nm);
			$("#useapr_day").text(useapr_day);
			$("#allow_2025").text(allow_2025);
			$("#emiss_2025").text(emiss_2025);
			
			fnListBuildEnergyInfo(mgm_bld_pk, totarea);
		},
		error : function(err) {
//			alert("전송에 실패하였습니다 관리자 문의 바랍니다.");
		}
	});
	
}

function fnListBuildEnergyInfo(mgm_bld_pk, totarea){
	$.ajax({
		method : "POST",
		url : "/dash/listSeoulOwnTarget1EnergyLedger.do",
	    data : {
	    	"mgm_bld_pk":mgm_bld_pk
	    },
		dataType : "json",
		async : false,
		success : function(result){
			
			var listBuildEnergyInfo = result; 
			
			var tco2eq_t = 0;
			var tco2eq_t_area = 0;
			var tco2eq_e = 0;
			var tco2eq_g = 0;
			var tco2eq_l = 0;
			var energy_use_e = 0;
			var energy_use_g = 0;
			var energy_use_l = 0;
			
			for(i=0;i<listBuildEnergyInfo.length;i++){
				var energy_type = listBuildEnergyInfo[i].energy_type;
				var energy_use = listBuildEnergyInfo[i].energy_use;
				var tco2eq = listBuildEnergyInfo[i].tco2eq;
				if(energy_type == "전기"){
					tco2eq_e = tco2eq;
					energy_use_e = energy_use;
				} else if(energy_type == "가스"){
					tco2eq_g = tco2eq;
					energy_use_g = energy_use;
				} else if(energy_type == "지역난방"){
					tco2eq_l = tco2eq;
					energy_use_l = energy_use;
				}
			}
			
			tco2eq_t = tco2eq_e + tco2eq_g +tco2eq_l;
			tco2eq_t_area = Math.round((tco2eq_t / totarea), 5);
			
//			$("#tco2eq_t_area").html("단위면적당 온실가스 : " + tco2eq_t_area + "(tCO<sub>2</sub>/m<sup>2</sup>)");
			$("#tco2eq_t").html(numberWithCommas(Math.round(tco2eq_t)) + "(tCO<sub>2</sub>)");
			$("#energy_use_g").html(numberWithCommas(Math.round(energy_use_g)) + "(m<sup>3</sup>)");
			$("#tco2eq_g").html(numberWithCommas(Math.round(tco2eq_g)) + "(tCO<sub>2</sub>)");
			$("#energy_use_e").html(numberWithCommas(Math.round(energy_use_e)) + "(MWh)");
			$("#tco2eq_e").html(numberWithCommas(Math.round(tco2eq_e)) + "(tCO<sub>2</sub>)");
			$("#energy_use_l").html(numberWithCommas(Math.round(energy_use_l)) + "(Gcal)");
			$("#tco2eq_l").html(numberWithCommas(Math.round(tco2eq_l)) + "(tCO<sub>2</sub>)");
			
		},
		error : function(err) {
//			alert("전송에 실패하였습니다 관리자 문의 바랍니다.");
		}
	});
}

function numberWithCommas(x) {
	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); 
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
				var totarea = viewBuildInfoByMgmBldPk.totarea;
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
			}
			
			
		},
		error : function(err) {
			alert("데이터 조회가 지연되고 있습니다. 잠시후 다시 확인 바랍니다.");
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

function fnSelectYear(){
	var year = $('#year').val();
	var mgm_bld_pk = $('#selected_bd_mgm_bld_pk').html();
	fnListBuildEnergyInfoByMonth(mgm_bld_pk, year);
}