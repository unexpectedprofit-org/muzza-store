angular.module('MuzzaStore.order').controller 'OrderList', (OrderService, $scope, $ionicModal, OrderDetails) ->

  $scope.orders = OrderService.listOrders()

  $scope.takeOrder = (order) ->
    OrderService.acceptOrder order


  $scope.viewOrder = (order) ->

    details = $ionicModal.fromTemplateUrl '../app/scripts/order/templates/orders-details.html',
      scope: $scope,
      animation: 'slide-in-up'

    $scope.order = order
    details.then (modal) ->
      console.log "herehereee"
      $scope.orderDetails = new OrderDetails modal
      $scope.orderDetails.show()