checkOutService = ($resource) ->
  {
    list    : $resource('/resources/admits/check_out.json')
    start   : $resource('/resources/check_out/:id/start.json', {id:'@id'}, {'update': { method: 'PUT' }})
    stop    : $resource('/resources/check_out/:id/stop.json' , {id:'@id'}, {'update': { method: 'PUT' }})
    reset   : $resource('/resources/check_out/:id/reset.json', {id:'@id'})
    icon    : (step)->
      switch step.step
        when 'CHECK_OUT_DC'
          'fa-sticky-note'
        when 'CHECK_OUT_APPOINTMENT'
          'fa-envelope-o'
        when 'CHECK_OUT_RETURN_MED'
          'fa-medkit'
        when 'CHECK_OUT_CONTACT_FAM'
          'fa-phone'
        when 'CHECK_OUT_PAYMENT'
          'fa-credit-card'
        when 'CHECK_OUT_PATIENT_LEAVE'
          'fa-sign-out'
        else
          'disabled'
  }

checkOutService.$inject = ['$resource']

angular.module('app').factory('checkOutService', checkOutService)