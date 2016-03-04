homeController = (admitService, wardService) ->
  vm = @
  vm.update = ()->
    wardService.free.query().$promise.then    (data)-> vm.wards   = data
    admitService.edd.query().$promise.then    (data)-> vm.dcSoon  = data
    admitService.today.query().$promise.then  (data)-> vm.admitTd = data

  vm.update()

  admitService.websocket.bind 'updated', (admit)->
    vm.update()

  return

homeController
  .$inject = ['admitService', 'wardService']

angular
  .module('app')
  .controller('homeController', homeController)