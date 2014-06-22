angular.module('MuzzaStore.store').controller 'StoreEditCtrl', ($scope, StoreService, $state) ->

  $scope.store = angular.copy StoreService.getDetails()

  $scope.cancel = () ->
    $state.go 'app.store-details'

  $scope.save = (store) ->
    StoreService.updateStore store
    $state.go 'app.store-details'