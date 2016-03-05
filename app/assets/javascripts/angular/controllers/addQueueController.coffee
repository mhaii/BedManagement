addQueuesCtrl = ($state, $filter, admitService, patientService)->
  @dateOptions = {
    minDate:      new Date()
    startingDay:  1
    dateDisabled: null
  }

  # if editing, set as searched and found
  if @searched = @patientFound  = @editing = patientService.admit
    @admit     = patientService.admit
    patientService.admit = null

  @search = =>
    @searched  = true
    patientService.patient.get({id: @admit.patient.hn}).$promise.then (patient)=>
      @admit   = { patient: if @patientFound = !patient.error then patient else null }

  @submit = =>
    @admit.admitted_date = $filter('date')(@admit.admitted_date, 'yyyy-MM-dd')

    unless @patientFound
      patientService.patients.save(@admit.patient).$promise.then =>
        @patientFound = true

    if @patientFound
      # create new if this page isn't referred for edit
      admit = if @editing then admitService.admit.update({id: @admit.id}, @admit) else admitService.admits.save(@admit)

      admit.$promise.then (data)=>
        $state.go('queue')
    return

  return

addQueuesCtrl
  .$inject = ['$state', '$filter', 'admitService', 'patientService']

angular.module('app').controller('addQueuesCtrl', addQueuesCtrl)