angular.module('MuzzaStore.product').controller 'ProductListCtrl', ($scope, StoreService) ->

  console.log "aaaaaaa"

  $scope.categories = StoreService.getProducts()

