angular.module('MuzzaStore.store').directive 'storeDetails', (StoreService, $state) ->
  restrict: 'EA'
  scope: {
  }
  templateUrl: '../app/scripts/store/templates/store-details.html'

  link: ($scope, ele, attrs, ctrl) ->

    $scope.store = StoreService.getDetails().data

    $scope.edit = (what) ->
      if what is 'hours'
        $state.go 'app.store-edit-hours'
      else
        $state.go 'app.store-edit'
