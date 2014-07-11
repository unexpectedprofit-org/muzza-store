angular.module('MuzzaStore.product').controller 'CategoryAddCtrl', ($scope, StoreService) ->

  $scope.addCategory = (categoryDesc) ->

    $scope.formSubmitted = true

    $scope.response = StoreService.addProductCategory categoryDesc

    if $scope.response.error is undefined
      $scope.category = ''
      $scope.categoryAddForm.$setPristine()

    $scope.response_msg = categoryDesc


