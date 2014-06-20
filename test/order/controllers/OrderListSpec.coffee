describe "Order controller", ->

  beforeEach ->
    module 'ionic'
    module "MuzzaStore.order"

  scope = rootScope = createController = listOrdersSpy = undefined
  createController = OrderService = undefined

  beforeEach ->
    module ($provide) ->
      $provide.value 'OrderService',
        listOrders: () -> null
        acceptOrder: () -> null
      null

  beforeEach ->
    inject ($controller, $rootScope, $injector) ->
      OrderService = $injector.get 'OrderService'
      scope = $rootScope.$new()
      createController = ()->
        $controller "OrderList",
          $scope: scope
          OrderService: OrderService

  describe "init", ->

    it "should have functions defined", ->
      createController {}
      expect(scope.orders).toBeDefined()
      expect(scope.takeOrder).toBeDefined()
      expect(scope.viewOrder).toBeDefined()

  describe "listOrders functionality", ->

    it "should call the service", ->
      listOrdersSpy = spyOn(OrderService, 'listOrders').and.callThrough()
      createController {}
      expect(listOrdersSpy).toHaveBeenCalled()

  describe "acceptOrder functionality", ->

    it "should call the service", ->
      acceptOrderSpy = spyOn(OrderService, 'acceptOrder').and.callThrough()
      createController {}
      order = {id:1}
      scope.takeOrder order

      expect(acceptOrderSpy).toHaveBeenCalledWith order

  describe "viewOrder functionality", ->

    it "should set order in scope", ->
      createController {}

      order = {id:1}
      scope.viewOrder order

      expect(scope.order).toEqual order