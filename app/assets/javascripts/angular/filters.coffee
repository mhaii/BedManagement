angular.module('app').filter 'dateTimeHumanize', ($filter)->
  (input) ->
    [nowTime, date] = [(new Date).getTime(), new Date(input)]
    dateDifference = nowTime - date.getTime()
    [prefix, suffix] = if dateDifference < 0 then [$filter('translate')('PREFIX_FROM_NOW'), $filter('translate')('SUFFIX_FROM_NOW')] else [$filter('translate')('PREFIX_AGO'), $filter('translate')('SUFFIX_AGO')]
    seconds = Math.abs(dateDifference) / 1000
    minutes = seconds / 60
    hours = minutes / 60
    days = hours / 24
    words = seconds < 45  and $filter('translate')('LESS_THAN_A_MINUTE') or
            seconds < 90  and $filter('translate')('MINUTE_TO_TIL') or
            minutes < 45  and $filter('translate')('MINUTES_TO_TIL', {minutes: Math.round minutes}) or
            minutes < 90  and $filter('translate')('HOUR_TO_TIL') or
            hours < 24    and $filter('translate')('HOURS_TO_TIL', {hours: Math.round hours}) or
            hours < 42    and $filter('translate')('DAY_TO_TIL') or
            days < 3      and $filter('translate')('DAYS_TO_TIL', {days: Math.round days})
    $.trim [date.toLocaleDateString(), date.toLocaleTimeString()].concat(words and ['(', prefix, words, suffix, ')'] or []).join ' '