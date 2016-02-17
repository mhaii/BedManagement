angular.module('app').config ($stateProvider, $urlRouterProvider, $httpProvider) ->
    $stateProvider.state("home",{
        url: "/",
        controller: "currentStatisticsCtrl as statCtrl"
        templateUrl: "templates/home/home.html"
    })
    $stateProvider.state("queues",{
        url: "/queues",
        controller: "queueController as qCtrl"
        templateUrl: "templates/queues/queues.html"
    })
    $stateProvider.state("add-queue",{
        url: "/add-queue",
        controller: "addQueuesCtrl as addCtrl"
        templateUrl: "templates/addQueue/add-queue.html"
    })
    $stateProvider.state("status",{
        url: "/status",
        controller: "BedStatusController as bedCtrl"
        templateUrl: "templates/bedStatus/bedstatus.html"
    })
    $urlRouterProvider.otherwise('/')
    #    $httpProvider.defaults.xsrfCookieName = 'csrftoken';
    #    $httpProvider.defaults.xsrfHeaderName = 'X-CSRFToken';
    return