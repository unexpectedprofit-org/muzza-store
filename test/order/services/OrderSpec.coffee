describe 'Order Service', ->

  beforeEach ->
    module 'MuzzaStore.order'

  OrderService = undefined

  beforeEach ->
    inject ($injector) ->
      OrderService = $injector.get 'OrderService'


  describe 'listOrdersByStatus', ->

    it 'should get an object of orders by status', ->
      orders = OrderService.listOrdersByStatus()
      expect((_.keys orders).length).toBe 6

      expect(orders.new.length).toBe 2
      expect(orders.progress.length).toBe 0
      expect(orders.pickup.length).toBe 0
      expect(orders.delivery.length).toBe 0
      expect(orders.close.length).toBe 0
      expect(orders.cancel.length).toBe 0


  describe 'acceptOrder', ->

    broadcastSpy = undefined

    it "should update the status from pending to in process", ->
      order =
        status: "NEW"
      OrderService.acceptOrder order
      expect(order.status).toEqual "IN_PROGRESS"

    it "should broadcast event", ->
      inject ($rootScope) ->
        broadcastSpy = spyOn($rootScope, '$broadcast')

        order =
          status: "NEW"
        OrderService.acceptOrder order

        expect(broadcastSpy).toHaveBeenCalled()