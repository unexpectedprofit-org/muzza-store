angular.module('MuzzaStore.product').controller 'ProductAddCtrl', ($scope, StoreService) ->

  getCategories = () ->
    StoreService.getProductCategories()

  $scope.options = ['SINGLE', 'MULTIPLE']
  $scope.categories = getCategories()

  $scope.product =
    options: []

  $scope.addProduct = (product) ->

    $scope.formSubmitted = true

    $scope.response = StoreService.addProduct product

    if $scope.response.error is undefined
      $scope.product =
        options: []
      $scope.productAddForm.$setPristine()

    $scope.response_msg = product.description