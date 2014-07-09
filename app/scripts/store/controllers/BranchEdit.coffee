angular.module('MuzzaStore.store').controller 'BranchEditCtrl', ($scope, StoreService, $state, $stateParams) ->

  generateTimeframeFlags = (openHours) ->
    days = []
    _.forEach (_.keys openHours), (key) ->
      days[key] =
        timeframe1: openHours[key].length > 0
        timeframe2: openHours[key].length > 1
    days


  branches = StoreService.getBranches().data
  branch = _.find branches, (branch) ->
    branch.id is parseInt $stateParams.id

  $scope.branch = branch
  $scope.days = generateTimeframeFlags branch.displayOpenHours

  $scope.cancel = () ->
    $state.go 'app.branches'

  $scope.save = (branch, days) ->

    _.forEach days, (day, idx) ->
      branch.displayOpenHours[idx] = []

      if day.timeframe1
        branch.displayOpenHours[idx].push [ branch.hours[idx].hours[0], branch.hours[idx].hours[1] ]

      if day.timeframe2
        branch.displayOpenHours[idx].push [ branch.hours[idx].hours[2], branch.hours[idx].hours[3] ]

    StoreService.updateBranch branch
    $state.go 'app.branches'