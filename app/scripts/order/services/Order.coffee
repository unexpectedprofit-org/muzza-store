angular.module('MuzzaStore.order').service 'OrderService', () ->

  getOrders = () ->
    order1 =
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

    order2 =
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

    [order1,order2]


  getOrdersByStatus = (status) ->
    orders = getOrders()
    _.filter orders, (order) ->
      order.status is status

  acceptOrder = (order) ->
    order.status = "IN_PROCESS"

  listOrdersByStatus: getOrdersByStatus
  acceptOrder: acceptOrder