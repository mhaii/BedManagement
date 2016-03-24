sessionService = ($resource, admitService, checkOutService, doctorService, statService, userService, wardService)->
  ######################## Misc helpers #######################
  @UTCDateTime     = (date)->  new Date(Date.UTC(date.getFullYear(), date.getMonth(), date.getDate(), date.getHours()-7, date.getMinutes(), date.getSeconds()))
  @isAuthorized    = (array)=> array.indexOf(@currentUser.role) != -1

  @websocket = new WebSocketRails(location.host + '/websocket').subscribe('admits')

  (@user = userService.currentUser.get()).$promise.then (user)=>   # removing () would break stuff!
    @currentUser        = user

    ################ Methods for refreshing data ################
    if @isAuthorized ['administrator', 'admission', 'nurse', 'nurseAssistance']
      updateAdmit           = => admitService.queue.query()   .$promise.then (data)=> @queues          = data
      updateICU             = => admitService.in_icu.query()  .$promise.then (data)=> @icuPatients     = data
      updateWards           = => wardService.all.query()      .$promise.then (data)=> @wards           = data

    if @isAuthorized ['administrator', 'admission', 'nurse', 'nurseAssistance']
      updateAdmittedToday   = => admitService.today.query()   .$promise.then (data)=> @admittedToday   = data
      updateDischargedSoon  = => admitService.edd.query()     .$promise.then (data)=> @dischargedSoon  = data
      updateDoctors         = => doctorService.all.query()    .$promise.then (data)=> @doctors         = data
      updateFreeRoomCount   = => wardService.free.query()     .$promise.then (data)=> @freeRoomCount   = data

    if @isAuthorized ['administrator', 'cashier']
      updateCheckOut        = => checkOutService.list.query() .$promise.then (data)=> @checkouts       = data

    if @isAuthorized ['administrator', 'executive']

      @updateStats = =>
        console.log 'updated!'

    ############### Fetch data based on user role ###############
    updateAdmit?()
    updateAdmittedToday?()
    updateCheckOut?()
    updateDischargedSoon?()
    updateDoctors?()
    updateFreeRoomCount?()
    updateICU?()
    @updateStats?()
    updateWards?()

    ############# Bind fetch method with websocket ##############
    @websocket.bind 'updated', (admit)->
      updateAdmit?()
      updateAdmittedToday?()
      updateDischargedSoon?()
      updateFreeRoomCount?()
      updateWards?()

    @websocket.bind 'check_out', (step)->
      updateCheckOut?()
      updateWards?()

    @websocket.bind 'destroyed', ()->
      updateAdmit?()

    @websocket.bind 'icu', (admit)->
      updateICU?()
  @

sessionService.$inject = ['$resource', 'admitService', 'checkOutService', 'doctorService', 'statService', 'userService', 'wardService']

angular.module('app').factory('sessionService', sessionService)