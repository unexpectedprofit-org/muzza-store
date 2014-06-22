describe 'StoreEditCtrl', ->

  beforeEach ->
    module 'MuzzaStore.store'

    module ($provide) ->
      $provide.value 'StoreService',
        getDetails: () -> {}
        updateStore: (store) -> {}

      $provide.value '$state',
        go: () -> null

      null

  scope = getDetailsSpy = goSpy = undefined
  StoreService = createController = $state = undefined

  beforeEach ->
    inject ($controller, $injector, $rootScope) ->
      StoreService = $injector.get 'StoreService'
      $state = $injector.get '$state'

      getDetailsSpy = spyOn(StoreService, 'getDetails').and.callThrough()
      goSpy = spyOn($state, 'go').and.callThrough()

      scope = $rootScope.$new()
      createController = () ->
        $controller "StoreEditCtrl",
          $scope: scope
          StoreService: StoreService

  describe "init", ->

    beforeEach ->
      createController()

    it "should call service to get store details", ->
      expect(getDetailsSpy).toHaveBeenCalled()

    it "should set a store object in the scope", ->
      expect(scope.store).toBeDefined()


  describe "save", ->

    updateSpy = undefined

    beforeEach ->
      updateSpy = spyOn(StoreService, 'updateStore').and.callThrough()
      createController()
      scope.save {}

    it "should call service", ->
      expect(updateSpy).toHaveBeenCalledWith {}

    it "should redirect to store details page", ->
      expect(goSpy).toHaveBeenCalledWith 'app.store-details'


  describe "cancel", ->

    beforeEach ->
      createController()

    it "should redirect to store details page", ->
      scope.cancel()
      expect(goSpy).toHaveBeenCalledWith 'app.store-details'