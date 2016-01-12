$( document ).ready(function () {
    $('#patientflow').highcharts({
        chart: {
            type: 'column'
        },
        title: {
            text: 'การจัดจำหน่าย'
        },
        xAxis: {
            categories: ['5:00', '6:00', '7:00', '8:00', '9:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00', '17:00', '18:00', '19:00', '20:00', '21:00', '22:00', '23:00', '0:00', '1:00', '2:00', '3:00', '4:00']
        },
        yAxis: {
            title: {
                text: 'Number of patients'
            }
        },
        series: [{
            name: 'Discharge',
            data: [1, 0, 4, 4, 5, 6, 7, 8, 9, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 1, 3, 4, 5]
        }, {
            name: 'Check-in',
            data: [5, 7, 3, 4, 5, 6, 7, 7, 8, 9, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 5, 4, 3, 1]
        }, {
            name: 'Discharge-Order',
            data: [4, 4, 4, 5, 6, 7, 8, 9, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 9, 0, 4, 3, 5, 1]
        }]
    });

    $('#acceptvsnot').highcharts({
        colorAxis: {
            minColor: '#00ff00',
            maxColor: '#ff0000'
        },
        series: [{
            type: 'treemap',
            layoutAlgorithm: 'squarified',
            data: [{
                name: 'Accepted',
                value: 10,
                colorValue: 1
            }, {
                name: 'Rejected',
                value: 3,
                colorValue: 2
            }]
        }],
        title: {
            text: 'Accept Reject Ratio per day'
        }
    });
    $('#turnover').highcharts({
        chart: {
            type: 'gauge'
        },
        title: {
            text: 'Turn-over rate'
        },
        pane: {
            startAngle: -150,
            endAngle: 150
        },
        yAxis: [{
            min: 0,
            max: 100,
            lineColor: '#339',
            tickColor: '#339',
            minorTickColor: '#339',
            offset: -5,
            lineWidth: 2,
            labels: {
                distance: -20,
                rotation: 'auto'
            },
            tickLength: 5,
            minorTickLength: 5,
            endOnTick: false
        }],
        series: [{
            name: 'Rate',
            data: [80],
            dataLabels: {
                text: '80%'
            },
            backgroundColor: {
                linearGradient: {
                    x1: 0,
                    y1: 0,
                    x2: 0,
                    y2: 1
                },
                stops: [
                    [0, '#DDD'],
                    [1, '#FFF']
                ]
            },
            tooltip: {
                valueSuffix: ' %'
            }
        }]
    });
});