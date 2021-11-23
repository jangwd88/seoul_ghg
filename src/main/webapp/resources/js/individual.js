
function fnCheckUserLikeBuild(mgm_bld_pk){
		
	var admin_id = $('#admin_id').val();
	
	$.ajax({
		url : "/individual/checkUserLikeBuild.do",
	    data : {
	    	"admin_id":admin_id	
	    	, "mgm_bld_pk":mgm_bld_pk
	    },
		dataType : "json",
		success : function(data) {
			var count = data;
			if(count == 0){
				$('#userLikeBuildStatus').val("dislike");
				$('#div_like_a').show();
				$('#div_like_b').hide();
				return;
			} else if(count == 1){
				$('#userLikeBuildStatus').val("like");
				$('#div_like_a').hide();
				$('#div_like_b').show();
				return;
			}
		},
		error : function(err) {
			console.log(err);
		}
   });
}


function fnSetUserLikeBuild(){
	
	var admin_id = $('#admin_id').val();
	var mgm_bld_pk = $('#selected_bd_mgm_bld_pk').html();
	var userLikeBuildStatus = $('#userLikeBuildStatus').val();
	
	$.ajax({
		url : "/individual/setUserLikeBuild.do",
	    data : {
	    	"admin_id":admin_id	
	    	, "mgm_bld_pk":mgm_bld_pk
	    	, "userLikeBuildStatus" : userLikeBuildStatus
	    },
		dataType : "json",
		success : function(data) {
			if(userLikeBuildStatus == "like"){
				$('#userLikeBuildStatus').val("dislike");
				$('#div_like_a').show();
				$('#div_like_b').hide();
				return;
			} else {
				$('#userLikeBuildStatus').val("like");
				$('#div_like_a').hide();
				$('#div_like_b').show();
				return;
			}
		},
		error : function(err) {
			console.log(err);
		}
   });
	
}

function fnSelectListUserLikeBuild(){
	
	var admin_id = $("#admin_id").val();
	
	$.ajax({
		method : "POST",
		url : "/individual/selectListUserLikeBuild.do",
	    data : {
	    	"admin_id":admin_id
	    },
		dataType : "json",
		async : true,
		success : function(result){
			
			var selectListUserLikeBuild = result;
			if(selectListUserLikeBuild == null){
				alert("수집된 데이터가 없습니다..");
			} else {
				var resultTableHtml = "";
				var init_x = 0;
				var init_y = 0;
				
				for(i=0;i<selectListUserLikeBuild.length;i++){
					
					var juso = selectListUserLikeBuild[i].juso;
					var totarea = selectListUserLikeBuild[i].totarea;
					var mgm_bld_pk = selectListUserLikeBuild[i].mgm_bld_pk;
					var cons_nm = "-";
					if(selectListUserLikeBuild[i].cons_nm != null){
						cons_nm = selectListUserLikeBuild[i].cons_nm;
					}
					var main_purps_nm = selectListUserLikeBuild[i].main_purps_nm;
					var useapr_day = selectListUserLikeBuild[i].useapr_day;
					var x = 0;
					if(selectListUserLikeBuild[i].x != null){
						x = selectListUserLikeBuild[i].x;
						init_x = selectListUserLikeBuild[i].x;
					}
					var y = 0;
					if(selectListUserLikeBuild[i].y != null){
						y = selectListUserLikeBuild[i].y;
						init_y = selectListUserLikeBuild[i].y;
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
				if(selectListUserLikeBuild.length == 1){
					var x = 0;
					if(selectListUserLikeBuild[0].x != null){
						x = selectListUserLikeBuild[0].x;
					}
					var y = 0;
					if(selectListUserLikeBuild[0].y != null){
						y = selectListUserLikeBuild[0].y;
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
