angular.module('MuzzaStore.product').controller 'ProductListCtrl', ($scope, StoreService) ->

  $scope.categories = StoreService.getProducts().data

