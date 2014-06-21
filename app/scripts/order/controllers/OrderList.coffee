angular.module('MuzzaStore.order').controller 'OrderList', (OrderService, $scope) ->

  $scope.orders =
    new: OrderService.listOrdersByStatus 'NEW'
    progress: OrderService.listOrdersByStatus 'IN_PROGRESS'
    pickup: OrderService.listOrdersByStatus 'READY_PICKUP'
    delivery: OrderService.listOrdersByStatus 'DELIVERY'
    close: OrderService.listOrdersByStatus 'CLOSED'
    cancel: OrderService.listOrdersByStatus 'CANCELED'