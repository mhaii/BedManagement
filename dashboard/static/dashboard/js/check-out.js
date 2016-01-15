var my_app = angular.module('MyApp',['ng.django.forms']);

my_app.controller('myCtrl', function($scope) {
    $scope.myfunc = function() {
        $scope.count++
    }
});ß