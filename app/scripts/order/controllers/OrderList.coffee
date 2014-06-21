angular.module('MuzzaStore.order').controller 'OrderList', (OrderService, $scope, $rootScope) ->

  $scope.orders = OrderService.listOrdersByStatus()

  $rootScope.$on 'ORDER_STATUS_CHANGED', () ->
    $scope.orders = OrderService.listOrdersByStatus()

