angular.module('MuzzaStore.order').directive 'ordersList', ($ionicModal, OrderService, OrderDetails) ->
  restrict: 'EA'
  scope: {
    orders: '=ngModel'
    orderStatus: '@'
  }
  require: 'ngModel'
  templateUrl: '../app/scripts/order/templates/orders-list-status.html'

  link: ($scope, ele, attrs, ctrl) ->

    $scope.actionButtons =
      accept: false
      view: true
      ready: false
      close: false
      cancel: false

    $scope.takeOrder = (order) ->
      OrderService.acceptOrder order


    $scope.viewOrder = (order) ->
      details = $ionicModal.fromTemplateUrl '../app/scripts/order/templates/orders-details.html',
        scope: $scope,
        animation: 'slide-in-up'

      $scope.order = order
      details.then (modal) ->
        $scope.orderDetails = new OrderDetails modal
        $scope.orderDetails.show()