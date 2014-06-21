describe 'Order Service', ->

  beforeEach ->
    module 'MuzzaStore.order'

  OrderService = undefined

  beforeEach ->
    inject ($injector) ->
      OrderService = $injector.get 'OrderService'


  describe 'listOrdersByStatus', ->

    it 'should get an array of orders', ->
      expect(OrderService.listOrdersByStatus('NEW').length).toBe 2
      expect(OrderService.listOrdersByStatus('IN_PROGRESS').length).toBe 0
      expect(OrderService.listOrdersByStatus('READY_PICKUP').length).toBe 0
      expect(OrderService.listOrdersByStatus('DELIVERY').length).toBe 0
      expect(OrderService.listOrdersByStatus('CLOSED').length).toBe 0
      expect(OrderService.listOrdersByStatus('CANCELED').length).toBe 0


  describe 'acceptOrder', ->

    it "should update the status from pending to in process", ->
      order =
        status: "NEW"
      OrderService.acceptOrder order
      expect(order.status).toEqual "IN_PROCESS"