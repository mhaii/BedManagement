addQueuesCtrl = ($http,searchService,$window)->
  vm = @
  patient = false
  vm.isNotSearch = true
  vm.isNotFoundPatient = false
  vm.admitInfo = {
    doctor: '',
    status: 0,
    admit_date: '',
    edd: null,
    symptom: ''
    patient: ''
    room: null
  }

  vm.search = ()->
    vm.patientInfo = {
      hn : vm.patientInfo.hn
      first_name: '',
      last_name: '',
      phone: '',
    }
    searchService.get({id: vm.patientInfo.hn}).$promise.then((user)->
      vm.isNotSearch = false
      if user.detail
        console.log(user)
        vm.isNotFoundPatient = true
      else
        console.log(user)
        patient = true
        vm.patientInfo.first_name = user.first_name
        vm.patientInfo.last_name = user.last_name
        vm.patientInfo.phone = user.phone
        vm.admitInfo.patient = vm.patientInfo.hn
        vm.isNotFoundPatient = false
    )
    return

  vm.addToQueue = ()->
    if patient
      vm.admitInfo.admit_date = vm.admitInfo.admit_date+'T00:00'
      $http(
        method: 'POST',
        url: '/api/admits/',
        data: vm.admitInfo
      ).then((data)->
        console.log('done')
        window.location.href = 'http://127.0.0.1:8000/queues'
        return
      )
    else
      console.log(vm.patientInfo)
      $http(
        method: 'POST',
        url: '/api/patients/'
        data: vm.patientInfo
      ).then(->
        vm.admitInfo.patient = vm.patientInfo.hn
        vm.admitInfo.admit_date = vm.admitInfo.admit_date+'T00:00'
        $http(
          method: 'POST',
          url: '/api/admits/',
          data: vm.admitInfo
        ).then((data)->
          console.log('done')
          window.location.href = 'http://127.0.0.1:8000/queues'
          return
        )
      )
    return
  return

searchService = ($resource)->
  $resource('/api/patients/:id/check',{id:'@id'})

addQueuesCtrl
  .$inject = ['$http','searchService','$window']

searchService
  .$inject = ['$resource']

angular
  .module('addQueueApp',['ng.django.urls','ngResource'])
  .config ($interpolateProvider, $httpProvider) ->
    $interpolateProvider.startSymbol('{$')
    $interpolateProvider.endSymbol('$}')
    $httpProvider.defaults.xsrfCookieName = 'csrftoken';
    $httpProvider.defaults.xsrfHeaderName = 'X-CSRFToken';
    return
  .factory('searchService', searchService)
  .controller('addQueuesCtrl', addQueuesCtrl)