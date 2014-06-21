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
      $scope.statusValue = "NEW"

      element = angular.element('<orders-list data-ng-model="ordersWithStatus" data-order-status="statusValue"></orders-list>')
      $compile(element)($rootScope)
      $scope.$digest()
      isolatedScope = element.isolateScope()

  describe "init", ->

    it "should have functions defined", ->
      expect(isolatedScope.takeOrder).toBeDefined()
      expect(isolatedScope.viewOrder).toBeDefined()
      expect(isolatedScope.dispatchOrder).toBeDefined()


  describe "evaluate config buttons display ", ->

    describe "accept button", ->

      it "should enable button", ->
        expect(isolatedScope.actionButtons.accept).toBeTruthy()

      it "should disable button", ->
        inject ($compile, $rootScope) ->
          $scope = $rootScope
          $scope.statusValue = "OTHER_STATUS"
          element = angular.element('<orders-list data-ng-model="ordersWithStatus" data-order-status="statusValue"></orders-list>')
          $compile(element)($rootScope)
          $scope.$digest()
          isolatedScope = element.isolateScope()

          expect(isolatedScope.actionButtons.accept).toBeFalsy()


    describe "ready button", ->

      it "should disable button", ->
        expect(isolatedScope.actionButtons.ready).toBeFalsy()

      it "should enable button", ->
        inject ($compile, $rootScope) ->
          $scope = $rootScope
          $scope.statusValue = "IN_PROGRESS"
          element = angular.element('<orders-list data-ng-model="ordersWithStatus" data-order-status="statusValue"></orders-list>')
          $compile(element)($rootScope)
          $scope.$digest()
          isolatedScope = element.isolateScope()

          expect(isolatedScope.actionButtons.ready).toBeTruthy()

    describe "delivery button", ->

      it "should disable button", ->
        expect(isolatedScope.actionButtons.delivery).toBeFalsy()

      it "should enable button", ->
        inject ($compile, $rootScope) ->
          $scope = $rootScope
          $scope.statusValue = "READY_DELIVERY"
          element = angular.element('<orders-list data-ng-model="ordersWithStatus" data-order-status="statusValue"></orders-list>')
          $compile(element)($rootScope)
          $scope.$digest()
          isolatedScope = element.isolateScope()

          expect(isolatedScope.actionButtons.delivery).toBeTruthy()

    describe "close button", ->

      it "should disable button", ->
        expect(isolatedScope.actionButtons.close).toBeFalsy()

      it "should enable button - when delivery", ->
        inject ($compile, $rootScope) ->
          $scope = $rootScope
          $scope.statusValue = "DELIVERY"
          element = angular.element('<orders-list data-ng-model="ordersWithStatus" data-order-status="statusValue"></orders-list>')
          $compile(element)($rootScope)
          $scope.$digest()
          isolatedScope = element.isolateScope()

          expect(isolatedScope.actionButtons.close).toBeTruthy()

      it "should enable button - when pickup", ->
        inject ($compile, $rootScope) ->
          $scope = $rootScope
          $scope.statusValue = "READY_PICKUP"
          element = angular.element('<orders-list data-ng-model="ordersWithStatus" data-order-status="statusValue"></orders-list>')
          $compile(element)($rootScope)
          $scope.$digest()
          isolatedScope = element.isolateScope()

          expect(isolatedScope.actionButtons.close).toBeTruthy()


  describe "takeOrder functionality", ->

    it "should call the service", ->
      inject ($injector) ->
        OrderService = $injector.get 'OrderService'
        acceptOrderSpy = spyOn(OrderService, 'acceptOrder')
        order = {id:1}
        isolatedScope.takeOrder order

        expect(acceptOrderSpy).toHaveBeenCalledWith order

  describe "dispatch functionality", ->

    it "should call the service", ->
      inject ($injector) ->
        OrderService = $injector.get 'OrderService'
        dispatchOrderSpy = spyOn(OrderService, 'dispatchOrder')
        order = {id:1}
        isolatedScope.dispatchOrder order

        expect(dispatchOrderSpy).toHaveBeenCalledWith order

  describe "close functionality", ->

    it "should call the service", ->
      inject ($injector) ->
        OrderService = $injector.get 'OrderService'
        closeOrderSpy = spyOn(OrderService, 'closeOrder')
        order = {id:1}
        isolatedScope.closeOrder order

        expect(closeOrderSpy).toHaveBeenCalledWith order

  describe "viewOrder functionality", ->

    it "should set order in scope", ->
      order = {id:1}
      isolatedScope.viewOrder order

      expect(isolatedScope.order).toEqual order