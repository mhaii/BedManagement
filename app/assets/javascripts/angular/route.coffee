angular.module('app').config ($stateProvider, $urlRouterProvider, $httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')

  $stateProvider.state('home',{
      url: '/',
      controller: 'currentStatisticsCtrl as statCtrl'
      templateUrl: 'templates/home.html'
  })
  $stateProvider.state('queue',{
      url: '/queue',
      controller: 'queueController as qCtrl'
      templateUrl: 'templates/queues.html'
  })
  $stateProvider.state('add-queue',{
      url: '/add-queue',
      controller: 'addQueuesCtrl as addCtrl'
      templateUrl: 'templates/add-queue.html'
  })
  $stateProvider.state('status',{
      url: '/status',
      controller: 'BedStatusController as bedCtrl'
      templateUrl: 'templates/bed-status.html'
  })
  $urlRouterProvider.otherwise('/')

  return