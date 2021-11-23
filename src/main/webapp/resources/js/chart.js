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
			label : "전기",
			data : listEnergy_UseVal,
			borderColor: "rgba(255, 201, 14, 1)",
            backgroundColor: "rgba(255, 201, 14, 0.5)",
            fill: false
		},
		{
			label : "가스",
			data : listTco2eqVal,
			borderColor: "rgba(255, 255, 14, 1)",
            backgroundColor: "rgba(255, 255, 14, 0.5)",
            fill: false
		},
		{
			label : "지역난방",
			data : listTco2eqVal,
			borderColor: "rgba(255, 255, 14, 1)",
            backgroundColor: "rgba(255, 255, 14, 0.5)",
            fill: false
		},
		]
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
                    display: true
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
                    display: true
                }
            }]
        }
	};

	var lineChart = new Chart(speedCanvas, {
		type : 'bar',
		data : speedData,
		options : chartOptions
	});