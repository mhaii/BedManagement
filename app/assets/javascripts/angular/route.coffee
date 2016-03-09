angular.module('app').config ($stateProvider, $urlRouterProvider, $httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')

  $stateProvider.state 'home', {
    url: '/'
    controller: 'homeController'
    templateUrl: 'templates/home.html',
    data: {
      access: ['administrator', 'admission']
    }
  }
  $stateProvider.state 'queue', {
    url: '/queue'
    controller: 'queueController as queueCtrl'
    templateUrl: 'templates/tables/queues.html'
    data: {
      access: ['administrator', 'admission']
    }
  }
  $stateProvider.state 'add-queue', {
    url: '/add-queue'
    controller: 'addQueuesCtrl as addQueueCtrl'
    templateUrl: 'templates/add-queue.html'
    data: {
      access: ['administrator', 'admission']
    }
  }
  $stateProvider.state 'status', {
    url: '/status'
    controller: 'BedStatusController as bedCtrl'
    templateUrl: 'templates/bed-status.html'
    data: {
      access: ['administrator', 'admission', 'nurse', 'nurseAssistance']
    }
  }
  $stateProvider.state 'check-out', {
    url: '/check-out'
    controller: 'checkOutController as checkOutCtrl'
    templateUrl: 'templates/check-out.html'
    data: {
      access: ['administrator', 'nurse', 'nurseAssistance', 'cashier']
    }
  }
  $stateProvider.state 'statistic', {
    url: '/statistic'
    templateUrl: 'templates/statistic.html'
    data: {
      access: ['administrator', 'executive']
    }
  }
  $stateProvider.state 'create-user', {
    url: '/create-user'
    controller: 'createUserController as createUserCtrl'
    templateUrl: 'templates/create-user.html'
    data: {
      access: ['administrator']
    }
  }
  $stateProvider.state 'rainbow-unicorn', {
    url: '/rainbow-unicorn'
    data: {
      access: []
    }
  }
  $urlRouterProvider.otherwise('rainbow-unicorn')

  return