$(document).ready(function(){ 
	$('#loading').hide();
//	init();
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
}

//건물용도 모달
function checkLine(id){
	if(id == 'all'){
		$(".tempPurps").prop("checked",false);
	}else{
		$("#all").prop("checked",false);
	}
	$("#"+ id).prop("checked",true);
}

function confirmStat(id) {
	if(id == "modalPop_001"){
		var len = $('.tempPurps:checked').length;
		var name = $('.tempPurps:checked').eq(0).parent().next().html();
		if(len > 1){
			$("#statBtn").html(name+"외 "+(len-1)+" 건");	
		}else if(len == 1){
			$("#statBtn").html(name);
		}
		
		var value = "";
		for(var i =0;i<len;i++){
			value += $('.tempPurps:checked').eq(i).val()+",";
		}
		value = value.substr(0,value.lastIndexOf(","));
		$("#util").val(value)
		
	}
	$("#" + id).modal('hide');
}

function openModal(id) {
	$("#" + id).modal('show');
}


//노후도 다중선택
function checkOld(chk) {
	var old = document.getElementsByName("oldSelect");
	for (var i = 0; i < old.length; i++) {
		if (old[i] != chk) {
			old[i].checked = false;
		}
	}
}


// 노후도 전체 선택 및 전체 해제
function checkOldAll(){
	if($("#oldCheckAll").is(':checked')){
		$("input[name=oldSelect]").prop("checked",true);
	} else {
		$("input[name=oldSelect]").prop("checked",false);
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
				var optionHTML = '<option value="">선택</option>';
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
	
	var start_age_ratio = $('#start_age_ratio').val();
	var end_age_ratio = $('#end_age_ratio').val();

	var start_tot_area = $('#start_tot_area').val();
	var end_tot_area = $('#end_tot_area').val();
	
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

	if(arr_main_purps_cd.length == 0){
		alert("건물 용도를 선택해주세요.");
		return false;
	}
	
	$.ajax({
		method : "POST",
		url : "/space/selectArchList.do",
	    data : {
	    	"energy_type_electric":energy_type_electric,
	    	"energy_type_gas":energy_type_gas,
	    	"energy_type_local":energy_type_local,
	    	"arr_main_purps_cd":arr_main_purps_cd,
			"start_age_ratio":start_age_ratio,
			"end_age_ratio":end_age_ratio,
			"start_tot_area": start_tot_area,
			"end_tot_area":end_tot_area,
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
			fnShowContLdregLayer();
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


function jusoListSearch(){
	var juso= $('#keyword_juso').val();
	
	if(juso.trim() == ""){
		alert("검색어를 입력해 주세요.");
		return;
	}
	
	jQuery.ajax({
		url : "/select/selectJuso.do",
		data : {
			juso : juso
		}
		, async : true
		, dataType : "json"
		, type : "POST"
		, beforeSend : function(xhr, opts) {
		}
		, error : function(request, status, error) {
		}
		, success : function(result) {	
			var selectJusoList = result;
			var resultTableHtml ="";
			
			for(i=0;i<selectJusoList.length;i++){
				resultTableHtml = resultTableHtml +"<tr><td><input type='checkbox' value='"+selectJusoList[i].juso+"' name='cons_nm' ></td>"+ "<td>"+selectJusoList[i].juso+"</td></tr>"
			}
			$('#JusoTable > tbody').html("");
			$('#JusoTable > tbody').html(resultTableHtml);
		}
		, complete : function() {
		}
		});
}

var tileLayer;
var tileSource;
var wmsSource;
var wmsAdminSource;

var tileLayer2;
var tileSource2;
var wmsSource2;

//shp 불러오기
function fnShowShp() {
	var main_purps_cd = $('#main_purps_cd').val();
	var admin_cd_sgg = $('#admin_cd_sgg').val();
	var admin_cd_emd = $('#admin_cd_emd').val();//10단위
	var sig_cd = admin_cd_emd.substr(0,5);
	var emd_cd = admin_cd_emd.substr(5,3);
	var li_cd = admin_cd_emd.substr(8,2);
	
	$.ajax({
		method : "POST",
		url : "/space/listAdminHjCode.do",
	    data : {
	    	"admin_cd_emd":admin_cd_emd
	    },
		dataType : "json",
		async : false,
		success : function(result){
			
			var listAdminHjCode = result;
			
			var arrAdmDrCd = new Array();
			var pt;
			
			for(i=0;i<listAdminHjCode.length;i++){
				arrAdmDrCd.push(listAdminHjCode[i].adm_dr_cd);
				pt =[listAdminHjCode[i].x, listAdminHjCode[i].y];
			}
			
			//해당지역으로 이동
			map.getView().setCenter(pt);
			map.getView().setZoom(15);
			
			var filter = 'BDTYP_CD_2 IN ('+ arrMainPurpsCd +') AND SIG_CD = ' + sig_cd + ' AND EMD_CD = ' + emd_cd + ' AND LI_CD = ' + li_cd;
			var filter_2 = 'EMD_CD = ' + admin_cd_emd.substr(0,8);
			
			wmsAdminSource = new ol.layer.Image({
		        source: new ol.source.ImageWMS({
		        ratio: 1,
		        url: 'http://210.113.102.190:9090/seoul/wms',
		        params: {
		        		'VERSION': '1.1.1',  
		        		'STYLES': 'seoul_admin_style',
		                'LAYERS': 'seoul:LSMD_ADM_SECT_UMD',
		                'CQL_FILTER' : filter_2,
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
					'CQL_FILTER' : filter,
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


function fnListSameJusoBuild(bd_pk_1) {
	
	$.ajax({
		method : "POST",
		url : "/space/listSameJusoBuild.do",
	    data : {
	    	"bd_pk_1":bd_pk_1,
	    },
		dataType : "json",
		async : false,
		success : function(result){
			
			var listSameJusoBuild = result; 
			$( '#table_sameJusoBuild > tbody').empty();
			var tbodyHtml = "";
			
			if(listSameJusoBuild.length > 0){
				for(i=0;i<listSameJusoBuild.length;i++){
					
					var cons_nm = listSameJusoBuild[i].cons_nm;
					var dong_nm = listSameJusoBuild[i].dong_nm;
					var main_purps_nm = listSameJusoBuild[i].main_purps_nm;
					var useapr_day = listSameJusoBuild[i].useapr_day;
					var totarea = listSameJusoBuild[i].totarea;
					
					
					tbodyHtml = tbodyHtml + "<tr>";
					tbodyHtml = tbodyHtml + "<td>";
					tbodyHtml = tbodyHtml + i + 1;
					tbodyHtml = tbodyHtml + "</td>";
					
					tbodyHtml = tbodyHtml + "<td>";
					if(cons_nm != null){
						tbodyHtml = tbodyHtml + cons_nm;
					} else {
						tbodyHtml = tbodyHtml + "-";
					}
					tbodyHtml = tbodyHtml + "</td>";
					
					tbodyHtml = tbodyHtml + "<td>";
					if(dong_nm != null){
						tbodyHtml = tbodyHtml + cons_nm;
					} else {
						tbodyHtml = tbodyHtml + "-";
					}
					tbodyHtml = tbodyHtml + "</td>";
					
					tbodyHtml = tbodyHtml + "<td>";
					if(main_purps_nm != null){
						tbodyHtml = tbodyHtml + main_purps_nm;
					} else {
						tbodyHtml = tbodyHtml + "-";
					}
					tbodyHtml = tbodyHtml + "</td>";
					
					tbodyHtml = tbodyHtml + "<td>";
					if(useapr_day != null){
						tbodyHtml = tbodyHtml + useapr_day;
					} else {
						tbodyHtml = tbodyHtml + "-";
					}
					tbodyHtml = tbodyHtml + "</td>";
					
					tbodyHtml = tbodyHtml + "<td>";
					if(totarea != null){
						tbodyHtml = tbodyHtml + totarea + "m" + "<sup>2</sup>";
					} else {
						tbodyHtml = tbodyHtml + "-";
					}
					tbodyHtml = tbodyHtml + "</td>";
					
					tbodyHtml = tbodyHtml + "</tr>";
				}
			} else {
				tbodyHtml = tbodyHtml + "<td colspan='6'>데이터가 없습니다.</td>";
			}

			$( '#table_sameJusoBuild > tbody').append(tbodyHtml);
			
		},
		error : function(err) {
			alert("전송에 실패하였습니다 관리자 문의 바랍니다.");
		}
	});
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

	if (len == 0){
		main_purps_nm = "검색해주세요";
	}else if(len == 1){
		main_purps_nm = uniqueArr_nm[0];
	}else if(len > 1){
		main_purps_nm = uniqueArr_nm[0] + " 외 " + (len-1) + " 건  ";
	}
	
	$("#arr_main_purps_nm").text(main_purps_nm);
	
	$('#arch_type_modal').hide();
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

function fnListbuild(){

	var arr_main_purps_cd = arrMainPurpsCd;
	
	var start_age_ratio = $('#start_age_ratio').val();
	var end_age_ratio = $('#end_age_ratio').val();

	var start_tot_area = $('#start_tot_area').val();
	var end_tot_area = $('#end_tot_area').val();
	
	var si = $('#si').val();
	var sigungu_nm = $('#sigungu_nm').val();
	var bjdong_nm = $('#bjdong_nm').val();
	
	$.ajax({
		method : "POST",
		url : "/space/listArch.do",
	    data : {
	    	"arr_main_purps_cd":arr_main_purps_cd,
			"start_age_ratio":start_age_ratio,
			"end_age_ratio":end_age_ratio,
			"start_tot_area": start_tot_area,
			"end_tot_area":end_tot_area,
	    	"si":si,
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
	  			
	  			resultTableHtml = resultTableHtml + "<td style='font-size: 75%; padding: 1px'>";
	  			resultTableHtml = resultTableHtml + (i+1);
	  			resultTableHtml = resultTableHtml + "</td>";
	  			
	  			resultTableHtml = resultTableHtml + "<td style='font-size: 75%;'>";
	  			resultTableHtml = resultTableHtml + mgm_bld_pk;
	  			resultTableHtml = resultTableHtml + "</td>";
	  			
	  			resultTableHtml = resultTableHtml + "<td style='font-size: 75%;'>";
//	  			resultTableHtml = resultTableHtml + "<a href='#' onclick='javascript:fnMoveMap(" + x + "," + y + ", 18);'>";
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
			fnMoveMap(init_x, init_y, 14);
			
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
			
			_successSearch = false;
			
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
