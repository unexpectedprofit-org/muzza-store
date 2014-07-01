describe 'StoreDetails directive', ->

  beforeEach ->
    module 'MuzzaStore.store'
    module 'MuzzaStore.templates'

    module ($provide) ->
      $provide.value '$state',
        go: () -> null

      $provide.value 'StoreService',
        getDetails: () -> null
      null

  element = isolatedScope = $scope = $state = StoreService = undefined

  beforeEach ->
    inject ($rootScope, $compile, $injector) ->
      $state = $injector.get '$state'
      StoreService = $injector.get 'StoreService'

      spyOn(StoreService, 'getDetails').and.callThrough()


      $scope = $rootScope
      element = angular.element('<store-details></store-details>')
      $compile(element)($rootScope)
      $scope.$digest()
      isolatedScope = element.isolateScope()

  describe "init", ->

    it "should have functions defined", ->
      expect(isolatedScope.edit).toBeDefined()

    it "should have a store object defined", ->
      expect(isolatedScope.store).toBeDefined()


  describe "edit functionality", ->

    it "should call go on state", ->
      goSpy = spyOn($state, 'go')
      isolatedScope.edit()
      expect(goSpy).toHaveBeenCalled()

    it "should call go on state", ->
      goHoursSpy = spyOn($state, 'go')
      isolatedScope.edit('hours')
      expect(goHoursSpy).toHaveBeenCalled()


