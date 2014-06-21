angular.module('MuzzaStore.order').directive 'ordersList', ($ionicModal, OrderService, OrderDetails, ORDER_STATUS) ->
  restrict: 'EA'
  scope: {
    orders: '=ngModel'
    orderStatus: '='
  }
  require: 'ngModel'
  templateUrl: '../app/scripts/order/templates/orders-list-status.html'

  link: ($scope, ele, attrs, ctrl) ->

    $scope.actionButtons =
      accept: $scope.orderStatus is ORDER_STATUS.STATUS.NEW
      view: true
      ready: $scope.orderStatus is ORDER_STATUS.STATUS.IN_PROGRESS
      delivery: $scope.orderStatus is ORDER_STATUS.STATUS.READY_DELIVERY
      close: $scope.orderStatus is ORDER_STATUS.STATUS.DELIVERY or $scope.orderStatus is ORDER_STATUS.STATUS.READY_PICKUP
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

    $scope.dispatchOrder = (order) ->
      OrderService.dispatchOrder order

    $scope.deliverOrder = (order) ->
      OrderService.deliverOrder order

    $scope.closeOrder = (order) ->
      OrderService.closeOrder order
