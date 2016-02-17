angular
  .module('app',['templates', 'ui.router','ngRoute','myModule'])
  .config ($stateProvider, $urlRouterProvider, $httpProvider) ->
    $stateProvider.state("home",{
      url: "/",
      controller: "currentStatisticsCtrl as statCtrl"
      templateUrl: "templates/home/home.html"
    })
    $stateProvider.state("queue",{
      url: "/queue",
      controller: "queueController as qCtrl"
      templateUrl: "templates/queue/queue.html"
    })
    $stateProvider.state("add-queue",{
      url: "/add-queue",
      controller: "addQueueController as addQueueCtrl"
      templateUrl: "templates/add-queue.html"
    })
    $stateProvider.state("status",{
      url: "/status",
      controller: "bedController as bedCtrl"
      templateUrl: "templates/bed.html"
    })
    $urlRouterProvider.otherwise('/')
#    $httpProvider.defaults.xsrfCookieName = 'csrftoken';
#    $httpProvider.defaults.xsrfHeaderName = 'X-CSRFToken';
    return