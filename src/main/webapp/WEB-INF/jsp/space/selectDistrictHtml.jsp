<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<script>
	var listEnergy_Use = new Array();
	var listTCo2eq = new Array();
	var listEnergy_UseVal = new Array();
	var listTco2eqVal = new Array();
</script>

<c:if test="${not empty  listArch}">
	<c:forEach items="${listArch}" var="item">
		<c:if test="${item.energy_type eq '전기'}">
			<script>
				listEnergy_Use.push("${item.energy_type}");
				listTCo2eq.push("${item.energy_type}");
				listEnergy_UseVal.push("${item.energy_use_sum}");
				listTco2eqVal.push("${item.tco2eq_sum}");
			</script>
		</c:if>
	</c:forEach>
	<c:forEach items="${listArch}" var="item">
		<c:if test="${item.energy_type eq '가스'}">
			<script>
				listEnergy_Use.push("${item.energy_type}");
				listTCo2eq.push("${item.energy_type}");
				listEnergy_UseVal.push("${item.energy_use_sum}");
				listTco2eqVal.push("${item.tco2eq_sum}");
			</script>
		</c:if>
	</c:forEach>

	<c:forEach items="${listArch}" var="item">
		<c:if test="${item.energy_type eq '지역난방'}">
			<script>
				listEnergy_Use.push("${item.energy_type}");
				listTCo2eq.push("${item.energy_type}");
				listEnergy_UseVal.push("${item.energy_use_sum}");
				listTco2eqVal.push("${item.tco2eq_sum}");
			</script>
		</c:if>
	</c:forEach>

</c:if>

<script>
	//Line
	
	var speedCanvas = document.getElementById("speedChart");
	Chart.defaults.global.defaultFontFamily = "SeoulNamsan"
	Chart.defaults.global.defaultFontSize = 18;
	
	var energyData = {
		labels: listEnergy_Use, listTCo2eq,
		datasets: [
			{

				label: "사용량",
				borderColor: "#8181F7",
	            backgroundColor: "#CECEF6",
				data: listEnergy_UseVal
			},
			{
				label: "배출량",
				borderColor: "rgba(255, 201, 14, 1)",
	            backgroundColor: "rgba(255, 201, 14, 0.5)",
				data: listTco2eqVal
			}
		]
	};
	
	var chartOptions = {
	    scales: {
	        yAxes: [{
	            display: true,
	            ticks: {
	                beginAtZero: true,
	                callback: function(value, index, values) {
	                    if(parseInt(value) >= 1000){
	                    	return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	                    } else {
	                    	return value;
	                    }
	                },
	                fontSize: 12
	            }
	        }]
	    },
	    tooltips: {
            callbacks: {
                label: function(tooltipItem, data) {
                    var label = data.datasets[tooltipItem.datasetIndex].label || '';

                    if (label) {
                        label += ': ';
                    }
                    label += numberWithCommas(tooltipItem.yLabel);
                    return label;
                }
            }
        }
	};
	
	function numberWithCommas(x) {
		return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); 
	}

	var lineChart = new Chart(speedCanvas, {
		type : 'bar',
		data : energyData
	});
	
	lineChart.options = chartOptions;
    lineChart.update();
    
    /* 엑셀 다운로드 버튼 이벤트*/
    $('#btnExcelDownload').click(function(){
    	console.log(_successSearch)
        if(_successSearch){
        	alert("조회된 데이터를 엑셀로 다운로드합니다.");
        	_excelDownload();
        }else{
        	alert("데이터를 조회해주세요.");
        }
    });
	
</script>

<div class="card" style="margin-bottom: 15px;">
	<div class="card-header">
		<h3 class="card-title">행정구역별 사용량 및 배출량 그래프</h3>
	</div>
	<div class="card-body" style="height: 360px;">
		<canvas id="speedChart" style="height: 295px; width: 481px; display: block; padding-bottom: 10px;"></canvas>
		<c:set var="sum" value="0" />
		<c:forEach items="${listArch}" var="item">
			<c:set var="sum" value="${sum + item.tco2eq_sum}" />
		</c:forEach>
		<p style="color: orange; margin-bottom: 0px;">
			※조회 조건에 따른 총 배출량 :
			<fmt:formatNumber type="number" maxFractionDigits="3" value="${sum }" />
			(tCO<sub>2</sub>)
		</p>
		<p style="color: orange;">※조회 조건에 따른 사용량 및 배출량 합계임.</p>
	</div>
</div>

<div class="card" id="right_list_size">
	<h3 class="card-header">에너지원 사용량 및 배출량</h3>
	<div class="card-body" style="height: 360px; padding-top: 10px; padding-bottom: 10px;">
		<table class="table table-hover table-project-tasks" summary="조회 항목 차트">
			<thead>
				<tr>
					<th></th>
					<th>에너지사용량</th>
					<th>온실가스</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${not empty  listArch}">

					<tr>
						<td>합계</td>
						<td>-</td>
						<td id="tco2eq_t" style="text-align: right;">
							<c:set var="sum" value="0" />
							<c:forEach items="${listArch}" var="item">
								<c:set var="sum" value="${sum + item.tco2eq_sum}" />
							</c:forEach>
							<fmt:formatNumber type="number" maxFractionDigits="3" value="${sum }" />
							(tCO<sub>2</sub>)
						</td>
					</tr>


					<c:forEach items="${listArch}" var="item">
						<c:if test="${fn:contains(item.energy_type, '전기')}">
							<tr>
								<td>전기</td>
								<td id="energy_use_e" style="text-align: right;">
									<fmt:formatNumber type="number" maxFractionDigits="3" value="${item.energy_use_sum}" />
									(MWh)
								</td>
								<td id="tco2eq_e" style="text-align: right;">
									<fmt:formatNumber type="number" maxFractionDigits="3" value="${item.tco2eq_sum}" />
									(tCO<sub>2</sub>)
								</td>
							</tr>
						</c:if>
					</c:forEach>

					<c:forEach items="${listArch}" var="item">
						<c:if test="${fn:contains(item.energy_type, '가스')}">
							<tr>
								<td>가스</td>
								<td id="energy_use_g" style="text-align: right;">
									<fmt:formatNumber type="number" maxFractionDigits="3" value="${item.energy_use_sum}" />
									(1,000m<sup>3</sup>)
								</td>
								<td id="tco2eq_g" style="text-align: right;">
									<fmt:formatNumber type="number" maxFractionDigits="3" value="${item.tco2eq_sum}" />
									(tCO<sub>2</sub>)
								</td>
							</tr>
						</c:if>
					</c:forEach>

					<c:forEach items="${listArch}" var="item">
						<c:if test="${fn:contains(item.energy_type, '지역난방')}">
							<tr>
								<td>지역난방</td>
								<td id="energy_use_l" style="text-align: right;">
									<fmt:formatNumber type="number" maxFractionDigits="3" value="${item.energy_use_sum}" />
									(Gcal)
								</td>
								<td id="tco2eq_l" style="text-align: right;">
									<fmt:formatNumber type="number" maxFractionDigits="3" value="${item.tco2eq_sum}" />
									(tCO<sub>2</sub>)
								</td>
							</tr>
						</c:if>
					</c:forEach>
				</c:if>

				<c:if test="${empty  listArch}">
					<script>
						alert('조건에 맞는 데이터가 없습니다.');
					</script>
					<tr>
						<td colspan="3">데이터가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
	<div class="card-footer">
		<button id="btnExcelDownload" class="btn btn-success"><i class="fa fa-table mr-2" aria-hidden="true"></i><span>엑셀 다운로드</span></button>
	</div>
</div>
