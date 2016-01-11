$( document ).ready(function () {
        $('#container').highcharts({
            chart: {
                type: 'column'
            },
            title: {
                text: 'Turn-Over'
            },
            xAxis: {
                label: ['5:00', '6:00', '7:00','8:00','9:00','10:00','11:00','12:00','13:00','14:00','15:00','16:00','17:00','18:00','19:00','20:00', '21:00','22:00','23:00','0:00','1:00','2:00','3:00','4:00']
            },
            yAxis: {
                title: {
                    text: 'Number of patients'
                }
            },
            series: [{
                name: 'Discharge',
                data: [1, 0, 4,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0]
            }, {
                name: 'Check-in',
                data: [5, 7, 3,4,5,6,7,7,8,9,0,1,2,3,4,5,6,7,8,9]
            }, {
                name: 'Discharge-Order',
                data: [4, 4, 4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,9,0]
            }]
        });
});