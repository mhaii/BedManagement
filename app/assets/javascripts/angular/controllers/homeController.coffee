homeController = ($http, admitService, wardService) ->
  @wards = wardService.free.query()
  @dcSoon = admitService.edd.query()
  @admitTd = admitService.today.query()
  @

homeController
  .$inject = ['$http', 'admitService', 'wardService']

angular
  .module('app')
  .controller('homeController', homeController)