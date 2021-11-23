$(document).ready(function(){ 
	$('#loading').hide();
	init();
});

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

var arrMainPurpsNm = new Array();
var arrMainPurpsCd = new Array();

function fnSelectMainPurps(){
	
	var main_purps_nm = $("#main_purps_cd option:checked").text();
	var main_purps_cd = $("#main_purps_cd").val();

	arrMainPurpsNm.push(main_purps_nm);
	arrMainPurpsCd.push(main_purps_cd);
	
	$("#arr_main_purps_nm").val(arrMainPurpsNm);
	
}

function jusoListSearch(){
	var juso = $('#keyword_juso').val();
	
	if(juso.trim() == ""){
		alert("검색어를 입력해 주세요.");
		return;
	}
	
	jQuery.ajax({
		url : "/space/listJuso.do",
		data : {
			juso : juso
		}
		, async : false
		, dataType : "json"
		, type : "POST"
		, beforeSend : function(xhr, opts) {
		}
		, error : function(request, status, error) {
		}
		, success : function(result) {	
			var listJuso = result;
			var resultTableHtml ="";
			
			for(i=0;i<listJuso.length;i++){
				resultTableHtml = resultTableHtml +"<tr><td><input type='radio' value='"+listJuso[i].juso+"' name='juso' ></td>"+ "<td>"+listJuso[i].juso+"</td></tr>"
			}
			$('#JusoTable > tbody').html("");
			$('#JusoTable > tbody').html(resultTableHtml);
		}
		, complete : function() {
		}
	});
}	
var arrJusoNm; 

function fnSelectJuso(){
	arrJusoNm = new Array();
	
	$("input:radio[name='juso']").each(function(){
			if($(this).is(":checked") == true) {
				
					$("#search_juso").val($(this).val());
					
					arrJusoNm.push($(this).val());
			}
		});
	
	const set_nm = new Set(arrJusoNm);
	const uniqueArr_nm = [...set_nm];
	
	var len = uniqueArr_nm.length;
	var jusoNmStr ="";
	
	
	if(len == 0){
		jusoNmStr = "검색해주세요";
	}
	else if(len == 1){
		jusoNmStr = uniqueArr_nm[0];
	}
	$('#juso_str').text(jusoNmStr);
	
	$('#juso_nm_modal').hide();		
}

function search(){
	var arr_juso = arrJusoNm;
	var search_juso = $("#search_juso").val();
		
	if(arr_juso == null || arr_juso.length == 0){
		alert("주소를 검색해주세요.");
		return false;
	}
	
	fnListBuildInfoByJuso();
}

function fnListBuildInfoByJuso(){
	
	var search_juso = $("#search_juso").val();
	
	$.ajax({
		method : "POST",
		url : "/space/listBuildInfoByJuso.do",
	    data : {
	    	"search_juso":search_juso
	    },
		dataType : "json",
		async : true,
		beforeSend : function(xhr, opts) {
			$('#loading').show();
	    },
		success : function(result){
			
			var listBuildInfoByJuso = result;
			if(listBuildInfoByJuso == null){
				alert("수집된 데이터가 없습니다..");
			} else {
				var resultTableHtml = "";
				var init_x = 0;
				var init_y = 0;
				
				for(i=0;i<listBuildInfoByJuso.length;i++){
					
					var juso = listBuildInfoByJuso[i].juso;
					var totarea = listBuildInfoByJuso[i].totarea;
					var mgm_bld_pk = listBuildInfoByJuso[i].mgm_bld_pk;
					var cons_nm = "-";
					if(listBuildInfoByJuso[i].cons_nm != null){
						cons_nm = listBuildInfoByJuso[i].cons_nm;
					}
					var main_purps_nm = listBuildInfoByJuso[i].main_purps_nm;
					var useapr_day = listBuildInfoByJuso[i].useapr_day;
					var x = 0;
					if(listBuildInfoByJuso[i].x != null){
						x = listBuildInfoByJuso[i].x;
						init_x = listBuildInfoByJuso[i].x;
					}
					var y = 0;
					if(listBuildInfoByJuso[i].y != null){
						y = listBuildInfoByJuso[i].y;
						init_y = listBuildInfoByJuso[i].y;
					}
					
		  			resultTableHtml = resultTableHtml + "<tr>";
		  			
		  			resultTableHtml = resultTableHtml + "<td style='font-size: 75%;'>";
		  			resultTableHtml = resultTableHtml + (i+1);
		  			resultTableHtml = resultTableHtml + "</td>";
		  			
		  			resultTableHtml = resultTableHtml + "<td style='font-size: 75%;'>";
		  			resultTableHtml = resultTableHtml + mgm_bld_pk;
		  			resultTableHtml = resultTableHtml + "</td>";
		  			
		  			resultTableHtml = resultTableHtml + "<td style='font-size: 75%;'>";
		  			resultTableHtml = resultTableHtml + `<a href="#" onclick="javascript:fnListBuildEnergyInfoByMonth2('${mgm_bld_pk}',2020,'${juso}','${totarea}','${main_purps_nm}','${useapr_day}','${x}','${y}');">`
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
				if(listBuildInfoByJuso.length == 1){
					var x = 0;
					if(listBuildInfoByJuso[0].x != null){
						x = listBuildInfoByJuso[0].x;
					}
					var y = 0;
					if(listBuildInfoByJuso[0].y != null){
						y = listBuildInfoByJuso[0].y;
					}
					if(x != 0 && y != 0){
						var coord = [x*1, y*1];
						fnFeatureSelect(coord);
						fnMoveMap(x*1,y*1,18);
					} else {
						alert("검색된 주소의 위치정보를 불러오지 못하였습니다.");
					}
				} else {
					fnMoveMap(init_x, init_y, 18);
				}
				
				$('#searchedBuildTable > tbody').html("");
				$('#searchedBuildTable > tbody').html(resultTableHtml);
				
			}
			
			$('#loading').hide();
		},
		error : function(err) {
			alert("데이터 조회가 지연되고 있습니다. 잠시후 다시 확인 바랍니다.");
			$('#loading').hide();
			return false;
		}
	});
	
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
			
			$('#tco2eq_t').html(numberWithCommas(Math.round(tco2eq_t * 100) / 100));
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

function fnListBuildEnergyInfoByMonth2(mgm_bld_pk, year, juso, totarea, main_purps_nm, useapr_day, x, y){
	
	
	
	fnMoveMap(x*1,y*1,18);//18
	
	var coord = [x*1, y*1];
	fnFeatureSelect(coord);
	
}


function numberWithCommas(x) {
	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); 
}

function fnSelectYear(){
	var year = $('#year').val();
	var mgm_bld_pk = $('#selected_bd_mgm_bld_pk').html();
	fnListBuildEnergyInfoByMonth(mgm_bld_pk, year);
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
      zoom: 11,
      minZoom : 10,
      maxZoom : 20
    }),
  logo:false
});

$(document).ready(function() {
	fnInitShowShp();
	fnShowContLdregLayer();
});

var tileLayer;
var tileSource;
var wmsSource;
var wmsAdminSource;

var tileLayer2;
var tileSource2;
var wmsSource2;

//shp 불러오기
function fnInitShowShp() {
			
	wmsAdminSource = new ol.layer.Image({
        source: new ol.source.ImageWMS({
        ratio: 1,
        url: 'http://210.113.102.190:9090/seoul/wms',
        params: {
        		'VERSION': '1.1.1',  
        		'STYLES': 'seoul_admin_style',
                'LAYERS': 'seoul:LSMD_ADM_SECT_UMD',
                "exceptions": 'application/vnd.ogc.se_inimage'
        	}
        }),
        layerId : 'layer_admin'
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


map.on('singleclick', function(evt) {
	
	var coordinate = evt.coordinate //좌표 정보
    var view = map.getView();
    var viewResolution = view.getResolution();
    var viewProjection = view.getProjection();
    console.log(viewProjection);
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
	
	if(bd_pk_1 == null || bd_pk_1 == ""){
		alert("수집된 데이터가 없습니다.");
	} else {
		fnViewBuildInfoByMgmBldPk(bd_pk_1);
	}
}

function init(){
   /*  기본 이벤트 등록 : 검색 버튼 키다운*/
   $(".keyword_juso").keydown(function(e){
      var enterKeyCode = 13;
      
      var element = $(this);
      var elName = element.attr("name");
      if(e.keyCode == enterKeyCode){
         console.log(elName);
         switch(elName){
            case "keyword_juso":
               jusoListSearch();
               break;
            case "keyword_juso2":
               break;
            default:
            
         }
      }
   })
   
   $(".adrbtn").click(function(e){
      jusoListSearch();
   })
}

function fnMoveMap(x,y,level){
	if(x == 0 || y == 0){
		alert("위치정보가 없습니다.");
	} else {
		var pt =[x*1, y*1];
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