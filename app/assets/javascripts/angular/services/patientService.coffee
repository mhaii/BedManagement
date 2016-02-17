patientService = ()->
  items = []
  rooms = []
  wards = []
  itemsService = {}
  itemsService.add = (item)->
    items.push(item)
    return
  itemsService.list = ()->
    items
  itemsService.clear = ()->
    items = []
    return
  itemsService.addRoom = (item)->
    rooms.push(item)
    return
  itemsService.clearRoom = ()->
    rooms = []
    return
  itemsService.listRoom = ()->
    rooms
  itemsService.addWard = (item)->
    wards.push(item)
    return
  itemsService.clearWard = ()->
    wards = []
    return
  itemsService.listWard = ()->
    wards
  itemsService

angular.module("app").factory('patientService', patientService)