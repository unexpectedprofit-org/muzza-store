describe "Order controller", ->

  beforeEach ->
    module 'ionic'
    module "MuzzaStore.order"

  scope = rootScope = createController = listOrdersSpy = undefined
  createController = OrderService = undefined

  beforeEach ->
    module ($provide) ->
      $provide.value 'OrderService',
        listOrdersByStatus: () -> null
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

  describe "listOrdersByStatus functionality", ->

    it "should call the service", ->
      listOrdersSpy = spyOn(OrderService, 'listOrdersByStatus').and.callThrough()
      createController {}
      expect(listOrdersSpy).toHaveBeenCalled()
      expect(listOrdersSpy.calls.count()).toBe 6