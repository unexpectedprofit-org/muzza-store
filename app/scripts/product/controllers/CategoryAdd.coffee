angular.module('MuzzaStore.product').controller 'CategoryAddCtrl', ($scope, StoreService) ->

  $scope.addCategory = (categoryDesc) ->
    $scope.response = StoreService.addProductCategory categoryDesc

    if $scope.response.error is undefined

      $scope.response.msg = "La categoria '" + categoryDesc + "' ha sido creada con exito!"
      $scope.category = ''
      $scope.categoryAddForm.$setPristine()
    else
      $scope.response.msg = "Se ha producido un error al intentar crear la categoria '" + categoryDesc + "'"


