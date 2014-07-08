describe 'StoreEditCtrl', ->

  beforeEach ->
    module 'MuzzaStore.store'

    module ($provide) ->
      $provide.value 'StoreService',
        getDetails: () -> {
          displayOpenHours:
              0: [ ]
              1: [ ['12:00', '14:00'], ['19:30', '03:00'] ]
              2: [ ['11:30', '15:00'], ['19:30', '22:00'] ]
              3: [ ['11:30', '15:00'], ['19:30', '22:00'] ]
              4: [ ['11:30', '15:00'], ['19:30', '01:00'] ]
              5: [ ['11:30', '15:00'], ['19:30', '02:30'] ]
              6: [ ['18:30', '03:00'] ]

          hours: [
            day: "Domingo"
            hours: []
          ,
            day: "Lunes"
            hours: ['12:00', '14:00', '19:30', '03:00']
          ,
            day: "Martes"
            hours: ['11:30', '15:00', '19:30', '22:00']
          ,
            day: "Miercoles"
            hours: ['11:30', '15:00', '19:30', '22:00']
          ,
            day: "Jueves"
            hours: ['11:30', '15:00', '19:30', '01:00']
          ,
            day: "Viernes"
            hours: ['11:30', '15:00', '19:30', '02:30']
          ,
            day: "Sabado"
            hours: ['18:30', '03:00']
          ]

        }
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

    it "should create day timeframe flags", ->
      expectedDays = [
        timeframe1: false
        timeframe2: false
      ,
        timeframe1: true
        timeframe2: true
      ,
        timeframe1: true
        timeframe2: true
      ,
        timeframe1: true
        timeframe2: true
      ,
        timeframe1: true
        timeframe2: true
      ,
        timeframe1: true
        timeframe2: true
      ,
        timeframe1: true
        timeframe2: false
      ]

      expect(scope.days).toEqual expectedDays


  describe "save", ->

    updateSpy = store = undefined

    beforeEach ->
      updateSpy = spyOn(StoreService, 'updateStore').and.callThrough()
      createController()

      timeframes = [
        timeframe1: true
        timeframe2: false
      ,
        timeframe1: true
        timeframe2: true
      ,
        timeframe1: true
        timeframe2: false
      ,
        timeframe1: true
        timeframe2: true
      ,
        timeframe1: true
        timeframe2: true
      ,
        timeframe1: true
        timeframe2: true
      ,
        timeframe1: false
        timeframe2: false
      ]

      scope.save scope.store, timeframes

    it "should call service", ->
      expect(updateSpy).toHaveBeenCalled()

    it "should update the hours based on flags", ->
      updatedStore = scope.store
      updatedStore[0] = [ ['11:00', '18:00'] ]
      updatedStore[1] = scope.store[1]
      updatedStore[2] = [ ['11:30', '15:00'] ]
      updatedStore[3] = scope.store[3]
      updatedStore[4] = scope.store[4]
      updatedStore[5] = scope.store[5]
      updatedStore[6] = []

      expect(updateSpy).toHaveBeenCalledWith updatedStore

    it "should redirect to store details page", ->
      expect(goSpy).toHaveBeenCalledWith 'app.store-details'


  describe "cancel", ->

    beforeEach ->
      createController()

    it "should redirect to store details page", ->
      scope.cancel()
      expect(goSpy).toHaveBeenCalledWith 'app.store-details'