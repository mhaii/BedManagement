angular.module('app').config ($stateProvider, $urlRouterProvider, $httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')

  $stateProvider.state('home',{
      url: '/',
      controller: 'homeController as homeCtrl'
      templateUrl: 'templates/home.html',
      data: {
        access: ['op', 'admission']
      }
  })
  $stateProvider.state('queue',{
      url: '/queue',
      controller: 'queueController as queueCtrl'
      templateUrl: 'templates/tables/queues.html'
      data: {
        access: ['op', 'admission']
      }
  })
  $stateProvider.state('add-queue',{
      url: '/add-queue',
      controller: 'addQueuesCtrl as addQueueCtrl'
      templateUrl: 'templates/add-queue.html'
      data: {
        access: ['op', 'admission']
      }
  })
  $stateProvider.state('status',{
      url: '/status',
      controller: 'BedStatusController as bedCtrl'
      templateUrl: 'templates/bed-status.html'
      data: {
        access: ['op', 'admission', 'nurse', 'nurseAssistance']
      }
  })
  $stateProvider.state('check-out',{
    url: '/check-out',
    templateUrl: 'templates/check-out.html'
    data: {
      access: ['op', 'nurse', 'nurseAssistance', 'cashier']
    }
  })
  $stateProvider.state('statistic',{
    url: '/statistic',
    templateUrl: 'templates/statistic.html'
    data: {
      access: ['administrator','op']
    }
  })
  $urlRouterProvider.otherwise('/')

  return