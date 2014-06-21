angular.module('MuzzaStore.order').service 'OrderService', ($rootScope, ORDER_STATUS) ->

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
  ,
    id: 3
    status: "NEW"
    contact:
      email: "aaa@aaajajajsa.com"
      name: "Gabriel"
      phone: "8888888888"
    delivery: "delivery"
    totalPrice: 30000
    products: [
      cat: "PIZZA"
      subcat: 1
      description: "Fugazzeta"
      qty: 1
      totalPrice: 8000
    ,
      cat: "PIZZA"
      subcat: 1
      description: "Napolitana"
      qty: 9
      totalPrice: 10000
    ,
      cat: "PIZZA"
      subcat: 3
      description: "Jamon y Morrones"
      qty: 2
      totalPrice: 12000
    ]
  ]



  getOrdersByStatus = () ->

    orders_new = _.filter storeOrders, (order) ->
      order.status is ORDER_STATUS.STATUS.NEW

    orders_progress = _.filter storeOrders, (order) ->
      order.status is ORDER_STATUS.STATUS.IN_PROGRESS

    orders_to_pickup = _.filter storeOrders, (order) ->
      order.status is ORDER_STATUS.STATUS.READY_PICKUP

    orders_to_deliver = _.filter storeOrders, (order) ->
      order.status is ORDER_STATUS.STATUS.READY_DELIVERY

    orders_in_delivery = _.filter storeOrders, (order) ->
      order.status is ORDER_STATUS.STATUS.DELIVERY

    orders_close = _.filter storeOrders, (order) ->
      order.status is ORDER_STATUS.STATUS.CLOSED

    orders_cancel = _.filter storeOrders, (order) ->
      order.status is ORDER_STATUS.STATUS.CANCELED

    {
      new:
        status: ORDER_STATUS.STATUS.NEW
        list: orders_new
      progress:
        status: ORDER_STATUS.STATUS.IN_PROGRESS
        list: orders_progress
      to_pickup:
        status: ORDER_STATUS.STATUS.READY_PICKUP
        list: orders_to_pickup
      to_deliver:
        status: ORDER_STATUS.STATUS.READY_DELIVERY
        list: orders_to_deliver
      delivery:
        status: ORDER_STATUS.STATUS.DELIVERY
        list: orders_in_delivery
      closed:
        status: ORDER_STATUS.STATUS.CLOSED
        list: orders_close
      canceled:
        status: ORDER_STATUS.STATUS.CANCELED
        list: orders_cancel
    }


  acceptOrder = (order) ->
    order.status = ORDER_STATUS.STATUS.IN_PROGRESS
    $rootScope.$broadcast 'ORDER_STATUS_CHANGED'

  dispatchOrder = (order) ->
    if order.delivery is "delivery"
      order.status = ORDER_STATUS.STATUS.READY_DELIVERY
    else
      order.status = ORDER_STATUS.STATUS.READY_PICKUP

    $rootScope.$broadcast 'ORDER_STATUS_CHANGED'

  closeOrder = (order) ->
    order.status = ORDER_STATUS.STATUS.CLOSED
    $rootScope.$broadcast 'ORDER_STATUS_CHANGED'

  deliverOrder = (order) ->
    order.status = ORDER_STATUS.STATUS.DELIVERY
    $rootScope.$broadcast 'ORDER_STATUS_CHANGED'



  listOrdersByStatus: getOrdersByStatus
  acceptOrder: acceptOrder
  dispatchOrder: dispatchOrder
  closeOrder: closeOrder
  deliverOrder: deliverOrder