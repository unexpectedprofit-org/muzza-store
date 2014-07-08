angular.module('MuzzaStore.store').controller 'StoreEditCtrl', ($scope, StoreService, $state) ->

  generateTimeframeFlags = (openHours) ->
    days = []
    _.forEach (_.keys openHours), (key) ->
      days[key] =
        timeframe1: openHours[key].length > 0
        timeframe2: openHours[key].length > 1
    days


  myStore = StoreService.getDetails().data

  $scope.store = myStore
  $scope.days = generateTimeframeFlags myStore.displayOpenHours

  $scope.cancel = () ->
    $state.go 'app.store-details'

  $scope.save = (store, days) ->

    _.forEach days, (day, idx) ->
      store.displayOpenHours[idx] = []
      if day.timeframe1
        store.displayOpenHours[idx].push [ store.hours[idx].hours[0], store.hours[idx].hours[1] ]

      if day.timeframe2
        store.displayOpenHours[idx].push [ store.hours[idx].hours[2], store.hours[idx].hours[3] ]

    StoreService.updateStore store
    $state.go 'app.store-details'