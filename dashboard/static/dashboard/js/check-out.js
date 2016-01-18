var my_app = angular.module('MyApp',[]).config(function($interpolateProvider) {
    $interpolateProvider.startSymbol('{$');
    $interpolateProvider.endSymbol('$}');
});
var toggle = 0;
my_app.controller('myCtrl', function($scope,$filter) {
    var statusP = 0;
    $scope.progStatus = "Should-Discharge Today";
    $scope.myfunc = function() {
        var date = new Date();

        if(toggle==0) {
            $scope.startTime = $filter('date')(new Date(), 'HH:mm:ss');
            $scope.endTime = "";
        }
        $scope.startTime = $filter('date')(new Date(), 'HH:mm:ss');

        statusP++;
        switch(statusP) {
            case 0:$scope.progStatus = "Should-Discharge Today";$scope.startTime = "";break;
            case 1:$scope.progStatus = "แพทย์เขียน Order D/C พร้อมสั่งยา Home Med";break;
            case 2:$scope.progStatus = "พยาบาลรับ Order D/C";break;
            case 3:$scope.progStatus = "พยาบาลออกใบนัด-รับใบนัด";break;
            case 4:$scope.progStatus = "พยาบาลคืนยากลับบ้าน";break;
            case 5:$scope.progStatus = "พยาบาลโทรติดต่อญาติ-ญาติมารับผู้ป่วย";break;
            case 6:$scope.progStatus = "พยาบาลตามหน่วยเคลื่อนย้ายผู้ป่วย";break;
            case 7:$scope.progStatus = "ผู้ป่วยออกจากหอผู้ป่วย";statusP = -1; break;
        }

    }

});