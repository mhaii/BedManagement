angular.module('app').filter 'dateHumanize', ($filter)->
  (input) ->
    date = new Date(input)
    [today, target] = [Math.floor((new Date).getTime() / 86398505), Math.floor(date / 86398505)]
    diff    = target - today

    !diff and 'TODAY' or diff == 1 and 'TOMORROW' or diff == -1 and 'YESTERDAY' or ''

angular.module('app').filter 'splitAndTranslate', ($filter)->
  (input) ->
    input.split(' ').map((word)-> $filter('translate')(word.replace /^\s+|\s+$/g, "")).join ' ' if input?