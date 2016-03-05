sessionService = ($resource, admitService, wardService)->
  (@currentUser = $resource('/sessions.json').get()).$promise.then (user)=>   # removing () would break stuff!
    ################ Methods for refreshing data ################
    updateAdmit           = => admitService.queue.query()  .$promise.then (data)=> @queues          = data
    updateAdmittedToday   = => admitService.today.query()  .$promise.then (data)=> @admittedToday   = data
    updateDischargedSoon  = => admitService.edd.query()    .$promise.then (data)=> @dischargedSoon  = data
    updateFreeRoomCount   = => wardService.free.query()    .$promise.then (data)=> @freeRoomCount   = data
    updateICU             = => admitService.in_icu.query() .$promise.then (data)=> @icuPatients     = data
    updateWards           = => wardService.all.query()     .$promise.then (data)=> @wards           = data

    ############### Fetch data based on user role ###############
    updateAdmit()
    updateAdmittedToday()
    updateDischargedSoon()
    updateFreeRoomCount()
    updateICU()
    updateWards()

    ############# Bind fetch method with websocket ##############
    @websocket = new WebSocketRails(location.host + '/websocket').subscribe('admits')

    @websocket.bind 'updated', (admit)->
      updateAdmit()
      updateAdmittedToday()
      updateDischargedSoon()
      updateFreeRoomCount()
      updateWards()

    @websocket.bind 'destroyed', ()->
      updateAdmit()

    @websocket.bind 'icu', (admit)->
      updateICU()
  @

sessionService.$inject = ['$resource', 'admitService', 'wardService']

angular.module('app').factory('sessionService', sessionService)