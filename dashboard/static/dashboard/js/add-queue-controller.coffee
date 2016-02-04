addQueuesCtrl = ($http,searchService)->
  vm = @
  vm.searchInput = { hnNumber : ''}
  vm.search = (hnNumber)->
    searchService.get({id: hnNumber.hnNumber}).$promise.then((user)->
      console.log(user)
    ,(error)->
      console.log(error) if error.status is 404
    )
    return

  vm.patientInfo = {
    first_name: '',
    last_name: '',
    phone: '',
    #sex: '',
    #age: '',
    status: 0,
    admit_date:'',
    symptom: '',
    doctor: '',
  }

  vm.addToQueue = (patientInfo)->
    $http(
      method: 'POST',
      url: '/api/admits/',
      data:{ Data: patientInfo }
    ).success((data)->
      console.log("done")
    ).error((data)->
      console.log(data)
    )
    return
  return

searchService = ($resource)->
  $resource('/api/patients/:id',{id:'@id'})

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