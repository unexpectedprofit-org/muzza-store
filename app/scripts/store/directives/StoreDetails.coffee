angular.module('MuzzaStore.store').directive 'storeDetails', (StoreService) ->

  restrict: 'EA'
  scope: {
  }
  templateUrl: '../app/scripts/store/templates/store-details.html'

  link: ($scope, ele, attrs, ctrl) ->

    $scope.store = StoreService.getDetails()
