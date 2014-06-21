describe 'Order Service', ->

  beforeEach ->
    module 'MuzzaStore.order'

  OrderService = ORDER_STATUS = undefined

  beforeEach ->
    inject ($injector) ->
      OrderService = $injector.get 'OrderService'
      ORDER_STATUS = $injector.get 'ORDER_STATUS'


  describe 'listOrdersByStatus', ->

    it 'should get an object of orders by status', ->
      orders = OrderService.listOrdersByStatus()
      expect((_.keys orders).length).toBe 7

      expect(orders.new.status).toEqual ORDER_STATUS.STATUS.NEW
      expect(orders.new.list.length).toBe 3

      expect(orders.progress.status).toEqual ORDER_STATUS.STATUS.IN_PROGRESS
      expect(orders.progress.list.length).toBe 0

      expect(orders.to_pickup.status).toEqual ORDER_STATUS.STATUS.READY_PICKUP
      expect(orders.to_pickup.list.length).toBe 0

      expect(orders.to_deliver.status).toEqual ORDER_STATUS.STATUS.READY_DELIVERY
      expect(orders.to_deliver.list.length).toBe 0

      expect(orders.delivery.status).toEqual ORDER_STATUS.STATUS.DELIVERY
      expect(orders.delivery.list.length).toBe 0

      expect(orders.closed.status).toEqual ORDER_STATUS.STATUS.CLOSED
      expect(orders.closed.list.length).toBe 0

      expect(orders.canceled.status).toEqual ORDER_STATUS.STATUS.CANCELED
      expect(orders.canceled.list.length).toBe 0


  describe 'acceptOrder', ->

    it "should update the status from pending to in process", ->
      order =
        status: ORDER_STATUS.STATUS.NEW
      OrderService.acceptOrder order
      expect(order.status).toEqual ORDER_STATUS.STATUS.IN_PROGRESS

    it "should broadcast event", ->
      inject ($rootScope) ->
        broadcastSpy = spyOn($rootScope, '$broadcast')

        order =
          status: ORDER_STATUS.STATUS.NEW
        OrderService.acceptOrder order

        expect(broadcastSpy).toHaveBeenCalled()


  describe "dispatchOrder", ->

    it "should change status to READY_PICKUP when pickup", ->
      order =
        id: 1
        delivery: "pickup"
        status: ORDER_STATUS.STATUS.IN_PROGRESS

      OrderService.dispatchOrder order

      expect(order.status).toBe ORDER_STATUS.STATUS.READY_PICKUP

    it "should change status to READY_DELIVERY when delivery", ->
      order =
        id: 1
        delivery: "delivery"
        status: ORDER_STATUS.STATUS.IN_PROGRESS

      OrderService.dispatchOrder order

      expect(order.status).toBe ORDER_STATUS.STATUS.READY_DELIVERY

    it "should broadcast event", ->
      inject ($rootScope) ->
        broadcastSpy = spyOn($rootScope, '$broadcast')

        order =
          status: ORDER_STATUS.STATUS.IN_PROGRESS
        OrderService.dispatchOrder order

        expect(broadcastSpy).toHaveBeenCalled()

  describe "closeOrder", ->

    it "should change status to CLOSED when pickup", ->
      order =
        id: 1
        delivery: "pickup"
        status: ORDER_STATUS.STATUS.READY_PICKUP

      OrderService.closeOrder order

      expect(order.status).toBe ORDER_STATUS.STATUS.CLOSED

    it "should change status to READY_DELIVERY when delivery", ->
      order =
        id: 1
        delivery: "delivery"
        status: ORDER_STATUS.STATUS.DELIVERY

      OrderService.closeOrder order

      expect(order.status).toBe ORDER_STATUS.STATUS.CLOSED

    it "should broadcast event", ->
      inject ($rootScope) ->
        broadcastSpy = spyOn($rootScope, '$broadcast')

        order =
          status: ORDER_STATUS.STATUS.DELIVERY
        OrderService.closeOrder order

        expect(broadcastSpy).toHaveBeenCalled()

  describe "deliverOrder", ->

    it "should change status to DELIVERY", ->
      order =
        id: 1
        status: ORDER_STATUS.STATUS.READY_DELIVERY

      OrderService.deliverOrder order

      expect(order.status).toBe ORDER_STATUS.STATUS.DELIVERY

    it "should broadcast event", ->
      inject ($rootScope) ->
        broadcastSpy = spyOn($rootScope, '$broadcast')

        order =
          status: ORDER_STATUS.STATUS.READY_DELIVERY
        OrderService.deliverOrder order

        expect(broadcastSpy).toHaveBeenCalled()