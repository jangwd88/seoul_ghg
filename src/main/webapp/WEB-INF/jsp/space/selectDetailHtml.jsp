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
	
	//Line
	//
	var speedCanvas = document.getElementById("speedChart");
	Chart.defaults.global.defaultFontFamily = "SeoulNamsan"
	Chart.defaults.global.defaultFontSize = 18;

	var speedData = {
		labels : listEnergy_Use,listTCo2eq,
		datasets : [ 
			{
			label : "사용량",
			data : listEnergy_UseVal,
			borderColor: "rgba(255, 201, 14, 1)",
            backgroundColor: "rgba(255, 201, 14, 0.5)",
            fill: false
		},
		{
			label : "Tco2eq",
			data : listTco2eqVal,
			borderColor: "#8181F7",
            backgroundColor: "#CECEF6",
            fill: false
		}]
	};

	var chartOptions = {
		responsive: true,
        title: {
            display: true,
//             text: '막대 차트 테스트'
        },
        tooltips: {
            mode: 'index',
            intersect: false,
            callbacks: {
                title: function(tooltipItems, data) {
                    return data.labels[tooltipItems[0].datasetIndex];
                }
            }
        },
        hover: {
            mode: 'nearest',
            intersect: true
        },
        scales: {
            xAxes: [{
                display: true,
                scaleLabel: {
                    display: true,
                    labelString: '에너지원',
                    fontColor : "red",
                	fontSize : "13"
                },
                ticks: {
                	fontSize : 12,
                    autoSkip: false
                }
            }],
            yAxes: [{
                display: true,
                ticks: {
                	fontSize : 12,
                    suggestedMin: 0,
                    beginAtZero: true,
                    userCallback: function(value, index, values) {
                        return value.toLocaleString();   // this is all we need
                    }
                },
                scaleLabel: {
                    display: true,
                    labelString : "에너지원 사용량",
                    fontColor : "green",
                    fontSize : "13"
                }
            }]
        }
	};

	var lineChart = new Chart(speedCanvas, {
		type : 'bar',
		data : speedData,
		options : chartOptions
	});
	
</script>

		<div class="card" style="margin-bottom: 15px;">
			<div class="card-header">
				<h3 class="card-title">건축물 에너지원 사용량 및 배출량 그래프</h3>
			</div>
			<div class="card-body" style="height: 360px;">
				<canvas id="speedChart" style="height: 300px; width: 481px; display: block; padding-bottom: 10px;"></canvas>
				<p style="color:orange;">※조회 조건에 따른 사용량 및 배출량 합계임.</p>
			</div>
		</div>

		<div class="card" id="right_list_size">
			<h3 class="card-header">에너지원 사용량 및 배출량</h3>
			<div class="card-body" style="height: 360px; padding-top: 10px; padding-bottom: 10px;">
				<table class="table table-hover table-project-tasks" summary="조회 항목 차트">
					<thead>
						<tr>
							<th style="text-align: center">에너지원</th>
							<th style="text-align: center">단위</th>
							<th style="text-align: center">사용량 및 배출량</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${not empty  listArch}">
							<c:forEach items="${listArch}" var="item">
								<c:if test="${fn:contains(item.energy_type, '전기')}">
									<tr style="text-align: center">
										<td>전기</td>
										<td>MWh</td>
										<td>
											<fmt:formatNumber type="number" maxFractionDigits="3" value="${item.energy_use_sum}" />
										</td>
									</tr>
									<tr style="text-align: center">
										<td>전기<br>온실가스</td>
										<td>tCO<sub>2</sub></td>
										<td>
											<fmt:formatNumber type="number" maxFractionDigits="3" value="${item.tco2eq_sum}" />
										</td>
									</tr>
								</c:if>
							</c:forEach>
							
							<c:forEach items="${listArch}" var="item">
								<c:if test="${fn:contains(item.energy_type, '가스')}">
									<tr style="text-align: center">
										<td>가스</td>
										<td>1,000m<sup>3</sup></td>
										<td>
											<fmt:formatNumber type="number" maxFractionDigits="3" value="${item.energy_use_sum}" />
										</td>
									</tr>
									<tr style="text-align: center">
										<td>가스<br>온실가스</td>
										<td>tCO<sub>2</sub></td>
										<td>
											<fmt:formatNumber type="number" maxFractionDigits="3" value="${item.tco2eq_sum}" />
										</td>
									</tr>
								</c:if>
							</c:forEach>
		
							<c:forEach items="${listArch}" var="item">
								<c:if test="${fn:contains(item.energy_type, '지역난방')}">
									<tr style="text-align: center">
										<td>지역난방</td>
										<td>Gcal</td>
										<td>
											<fmt:formatNumber type="number" maxFractionDigits="3" value="${item.energy_use_sum}" />
										</td>
									</tr>
									<tr style="text-align: center">
										<td>지역난방<br>온실가스</td>
										<td>tCO<sub>2</sub></td>
										<td>
											<fmt:formatNumber type="number" maxFractionDigits="3" value="${item.tco2eq_sum}" />
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
		</div>
