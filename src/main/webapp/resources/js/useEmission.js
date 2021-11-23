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



$(document).ready(function() {
	fnShowShp();
	fnNextViewSeoulOwnTarget1();
	setInterval(function(){ fnNextViewSeoulOwnTarget1(); }, 5000);
});

var tileLayer;
var tileSource;
var wmsSource;
var wmsAdminSource;

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

