angular.module('MuzzaStore.store').directive 'storeDetails', (StoreService, $state) ->
  restrict: 'EA'
  scope: {
  }
  templateUrl: '../app/scripts/store/templates/store-details.html'

  link: ($scope, ele, attrs, ctrl) ->

    $scope.branches = StoreService.getBranches().data
    console.log $scope.store

    $scope.edit = (what) ->
      if what is 'hours'
        $state.go 'app.store-edit-hours'
      else
        $state.go 'app.store-edit'
