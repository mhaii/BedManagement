addQueuesCtrl = ($http,searchService)->
  vm = @
  patient = false
  vm.patientInfo = {
    hn : ''
    first_name: '',
    last_name: '',
    phone: '',
  }

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
    searchService.get({id: vm.patientInfo.hn}).$promise.then((user)->
      if user.detail
        console.log(user)

      else
        console.log(user)
        patient = true
        vm.patientInfo.first_name = user.first_name
        vm.patientInfo.last_name = user.last_name
        vm.patientInfo.phone = user.phone
        vm.admitInfo.patient = vm.patientInfo.hn
    )
    return



  vm.addToQueue = ()->
    if patient
      vm.admitInfo.admit_date = vm.admitInfo.admit_date+'T00:00'
      $http(
        method: 'POST',
        url: '/api/admits/',
        data: vm.admitInfo
      ).success((data)->
        console.log("done")
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
        ).success((data)->
          console.log("done")
        )
      )
    return
  return

searchService = ($resource)->
  $resource('/api/patients/:id/check',{id:'@id'})

addQueuesCtrl
  .$inject = ['$http','searchService']

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