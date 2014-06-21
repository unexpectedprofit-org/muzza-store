describe "OrdersList", ->

  beforeEach ->
    module 'ionic'
    module 'MuzzaStore.templates'
    module 'MuzzaStore.order'

  isolatedScope = $scope = element = undefined

  beforeEach ->
    inject ($compile, $rootScope)->
      $scope = $rootScope

      $scope.ordersWithStatus = [
        id: 1
        desc: "Categ 1"
      ,
        id: 2
        desc: "Categ 2"
      ]

      element = angular.element('<orders-list data-ng-model="ordersWithStatus" data-order-status="exampleStatus"></orders-list>')
      $compile(element)($rootScope)
      $scope.$digest()
      isolatedScope = element.isolateScope()

  describe "init", ->

    it "should have config buttons set up in scope", ->

      expect(isolatedScope.actionButtons.accept).toBeFalsy()
      expect(isolatedScope.actionButtons.view).toBeTruthy()
      expect(isolatedScope.actionButtons.ready).toBeFalsy()
      expect(isolatedScope.actionButtons.close).toBeFalsy()
      expect(isolatedScope.actionButtons.cancel).toBeFalsy()

    it "should have functions defined", ->
      expect(isolatedScope.takeOrder).toBeDefined()
      expect(isolatedScope.viewOrder).toBeDefined()

      describe "acceptOrder functionality", ->

  describe "takeOrder functionality", ->

    it "should call the service", ->
      inject ($injector) ->
        OrderService = $injector.get 'OrderService'
        acceptOrderSpy = spyOn(OrderService, 'acceptOrder')
        order = {id:1}
        isolatedScope.takeOrder order

        expect(acceptOrderSpy).toHaveBeenCalledWith order

  describe "viewOrder functionality", ->

    it "should set order in scope", ->
      order = {id:1}
      isolatedScope.viewOrder order

      expect(isolatedScope.order).toEqual order