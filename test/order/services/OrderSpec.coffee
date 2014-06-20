describe 'Order Service', ->

  beforeEach ->
    module 'MuzzaStore.order'

  OrderService = undefined

  beforeEach ->
    inject ($injector) ->
      OrderService = $injector.get 'OrderService'


  describe 'listOrders', ->

    it 'should get an array of orders', ->
      expect(OrderService.listOrders().length).toBe 2

  describe 'acceptOrder', ->

    it "should update the status from pending to in process", ->
      order =
        status: "NEW"
      OrderService.acceptOrder order
      expect(order.status).toEqual "IN_PROCESS"