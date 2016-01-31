StatusController = ($filter)->
  statusP = 0
  vm = @
  vm.progStatus = "Should-Discharge Today"
  vm.changeStatus = ()->
    date = new Date()
    vm.startTime = $filter('date')(new Date(), 'HH:mm:ss')
    statusP = statusP + 1
    switch statusP
      when 0
        vm.progStatus = "Should-Discharge Today"
        vm.startTime = ''
      when 1 then vm.progStatus = "แพทย์เขียน Order D/C พร้อมสั่งยา Home Med"
      when 2 then vm.progStatus = "พยาบาลรับ Order D/C"
      when 3 then vm.progStatus = "พยาบาลออกใบนัด-รับใบนัด"
      when 4 then vm.progStatus = "พยาบาลคืนยากลับบ้าน"
      when 5 then vm.progStatus = "พยาบาลโทรติดต่อญาติ-ญาติมารับผู้ป่วย"
      when 6 then vm.progStatus = "พยาบาลตามหน่วยเคลื่อนย้ายผู้ป่วย"
      else
        vm.progStatus = "ผู้ป่วยออกจากหอผู้ป่วย"
        statusP = -1
        return
  return

angular
  .module('checkOutApp',[])
  .config ($interpolateProvider) ->
    $interpolateProvider.startSymbol('{$')
    $interpolateProvider.endSymbol('$}')
    return
  .controller('StatusController', StatusController)
