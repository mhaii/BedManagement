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
                case 1:$scope.progStatus = "Doctor Approved Discharge";break;
                case 2:$scope.progStatus = "ออกใบนัด";break;
                case 3:$scope.progStatus = "ส่งใบเบิกยา"; statusP = -1; break;
        }

    }

});