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
      zoom: 11,
      minZoom : 10,
      maxZoom : 20
    }),
  logo:false
  });



$(document).ready(function() {
	fnSelectFacilInfo('11140-100209993', '2020');
	fnListBuildEnergyInfoByMonth('11140-100209993', '2020');
	fnShowContLdregLayer();
	fnShowShp();
});

var tileLayer;
var tileSource;
var wmsSource;
var wmsAdminSource;

var tileLayer2;
var tileSource2;
var wmsSource2;

var bdpk = ''; //날짜 선택용 전역변수


//shp 불러오기
function fnShowShp() {
			
	wmsAdminSource = new ol.layer.Image({
        source: new ol.source.ImageWMS({
        ratio: 1,
        url: 'http://210.113.102.190:9090/seoul/wms',
        params: {
        		'VERSION': '1.1.1',  
        		'STYLES': 'seoul_admin_style',
                'LAYERS': 'seoul:LSMD_ADM_SECT_UMD',
        	}
        })
	});
	map.addLayer(wmsAdminSource);

	
	tileSource = new ol.source.TileWMS({
		url: 'http://210.113.102.190:9090/seoul/wms',
		params : {
			'LAYERS': 'seoul:TL_SPBD_BULD',
			'STYLES': 'seoul_buld_style',
			'VERSION' : '1.1.1',
			'REQUEST' : 'GetMap'
		},
		serverType : 'geoserver',
		crossOrigin : 'anonymous'
	});

	tileLayer = new ol.layer.Tile({
		source: tileSource,
		layerId : 'TL_SPBD_BULD'
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



//클릭이벤트 제거
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
				
				fnListBuildEnergyInfoByMonth(feature.properties.BD_PK_1, '2020');
				fnSelectFacilInfo(feature.properties.BD_PK_1, '2020');
				$("#year").val("2020").prop("selected", true);
				setHighlightFeature(geometry);

				return;
			}
		},
		error : function(err) {
			console.log(err);
		}
   });
	
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
	removePastLayer("highlight-layer");
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




function numberWithCommas(x) {
	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); 
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

function fnSelectFacilInfo(mgm_bld_pk, year){
	bdpk = mgm_bld_pk;
	$.ajax({
		method : "POST",
		url : "/dash/selectFacilInfo.do",
	    data : {
	    	"mgm_bld_pk":mgm_bld_pk,
	    	"year":year
	    },
		dataType : "json",
		async : false,
		success : function(result){
			$('#selected_bd_mgm_bld_pk').html(result.mgm_bld_pk);
			$('#selected_bd_juso').html(result.juso);
			$('#selected_bd_totarea').html(numberWithCommas(result.totarea));
			$('#selected_bd_main_purps_nm').html(result.main_purps_nm);
			$('#selected_bd_useapr_day').html(result.useapr_day);
			
			$('#arch_totarea').val(result.totarea);
		},
		error : function(err) {
			alert("데이터 조회가 지연되고 있습니다. 잠시후 다시 확인 바랍니다.");
		}
	});
}

function fnSelectYear(){
	var year = $('#year').val();
	fnListBuildEnergyInfoByMonth(bdpk, year);
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