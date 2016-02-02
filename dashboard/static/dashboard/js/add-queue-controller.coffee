addQueuesCtrl = ()->
  vm = @
  vm.searchInput = { hnNumber : ''}
  vm.search = (hnNumber)->
    console.log(hnNumber)
    return

  vm.patientInfo = {
    first_name: '',
    last_name: '',
    sex: '',
    age: '',
    symptom: '',
    doctor: '',
    admit_date:''
  }
  vm.addToQueue = (patientInfo)->
    console.log(patientInfo)
    return
  return

angular
  .module('addQueueApp',['ng.django.urls','ngResource'])
  .config ($interpolateProvider) ->
    $interpolateProvider.startSymbol('{$')
    $interpolateProvider.endSymbol('$}')
  .controller('addQueuesCtrl', addQueuesCtrl)