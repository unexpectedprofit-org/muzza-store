angular.module('MuzzaStore.product').controller 'ProductAddCtrl', ($scope, StoreService) ->

  getCategories = () ->
    StoreService.getProductCategories()

  $scope.options = ['SINGLE', 'MULTIPLE']
  $scope.categories = getCategories()

  $scope.product =
    options: []

  $scope.addProduct = (product) ->

    $scope.response = StoreService.addProduct product

    if $scope.response.status is 'ok'
      $scope.response.msg = "El producto '" + product.description + "' ha sido creado con exito!"

      $scope.product =
        options: []
      $scope.productAddForm.$setPristine()

    else
      $scope.response.msg = "Se ha producido un error al intentar crear el producto '" + product.description + "'"