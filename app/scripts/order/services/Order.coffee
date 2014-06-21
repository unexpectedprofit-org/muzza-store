angular.module('MuzzaStore.order').service 'OrderService', ($rootScope) ->

  storeOrders = [
    id: 1
    status: "NEW"
    contact:
      email: "aaa@aa.com"
      name: "Gonzalo"
      phone: "34242222111"
    delivery: "pickup"
    totalPrice: 14600
    products: [
      cat: "EMPANADA"
      subcat: 2
      description: "Carne cortada a cuchillo"
      qty: 2
      totalPrice: 4000
    ,
      cat: "EMPANADA"
      subcat: 2
      description: "Jamon y queso"
      qty: 3
      totalPrice: 10600
    ]
  ,
    id: 2
    status: "NEW"
    contact:
      email: "aaa@aaajajajsa.com"
      name: "Gabriel"
      phone: "8888888888"
    delivery: "pickup"
    totalPrice: 38300
    products: [
      cat: "EMPANADA"
      subcat: 1
      description: "Carne cortada a cuchillo"
      qty: 5
      totalPrice: 12000
    ,
      cat: "EMPANADA"
      subcat: 1
      description: "Cebolla y queso"
      qty: 9
      totalPrice: 10000
    ,
      cat: "PIZZA"
      subcat: 3
      description: "Jamon y Morrones"
      qty: 2
      totalPrice: 16300
    ]
  ]



  getOrdersByStatus = () ->

    orders_new = _.filter storeOrders, (order) ->
      order.status is "NEW"

    orders_progress = _.filter storeOrders, (order) ->
      order.status is "IN_PROGRESS"

    orders_pickup = _.filter storeOrders, (order) ->
      order.status is "READY_PICKUP"

    orders_delivery = _.filter storeOrders, (order) ->
      order.status is "DELIVERY"

    orders_close = _.filter storeOrders, (order) ->
      order.status is "CLOSED"

    orders_cancel = _.filter storeOrders, (order) ->
      order.status is "CANCELED"

    {
      new: orders_new
      progress: orders_progress
      pickup: orders_pickup
      delivery: orders_delivery
      close: orders_close
      cancel: orders_cancel
    }


  acceptOrder = (order) ->
    order.status = "IN_PROGRESS"
    $rootScope.$broadcast 'ORDER_STATUS_CHANGED'

  listOrdersByStatus: getOrdersByStatus
  acceptOrder: acceptOrder