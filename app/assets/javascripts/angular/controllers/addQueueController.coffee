addQueuesCtrl = ($state, $filter, admitService, patientService, sessionService)->
  @session = sessionService

  @data = ["Non-insulin-dependent diabetes mellitus, without complications", "Essential (primary) hypertension", "Need for immunization against rabies", "Chronic renal failure, unspecified", "Dyspepsia", "Diarrhoea and gastroenteritis of presumed infectious origin", "Peptic ulcer, site unspecified:", "Asthma, unspecified", "Stroke, not specified as haemorrhage or infarction", "Fever, unspecified"]

  @dateOptions = {
    minDate:      new Date()
    startingDay:  1
    dateDisabled: null
  }

  # if editing, set as searched and found
  if @searched = @patientFound  = @editing = sessionService.admit
    @admit     = sessionService.admit
    sessionService.admit = null
  else
    @admit      = {}

  @search = =>
    patientService.patient.get({id: @admit.patient.hn}).$promise.then (patient)=>
      @admit   = { patient: if @patientFound = !patient.error then patient else null }
      @searched  = true
    , =>
      @searched  = true

  @selectDoctor = (item)=>
    @admit.doctor_id = item.id

  @submit = =>
    saveAdmit = =>
      admit = if @editing then admitService.admit.update({id: @admit.id}, @admit) else admitService.admits.save(@admit)
      admit.$promise.then (data)=>
        $state.go('queue')

    if !isNaN(@doctor)
      @admit.doctor_id = @doctor

    if @patientFound
      @admit.patient_id   = @admit.patient.hn
      saveAdmit()
    else
      patientService.patients.save(@admit.patient).$promise.then (patient)=>
        @admit.patient_id = patient.hn
        saveAdmit()
    return

  return

addQueuesCtrl.$inject = ['$state', '$filter', 'admitService', 'patientService', 'sessionService']

angular.module('app').controller('addQueuesCtrl', addQueuesCtrl)