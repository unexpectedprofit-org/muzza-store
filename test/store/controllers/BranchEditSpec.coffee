describe 'BranchEdit Controller', ->

  beforeEach ->
    module 'MuzzaStore.store'

    module ($provide) ->
      $provide.value 'StoreService',
        getDetails: () -> {
          data:
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
        updateBranch: (branch) -> {}
        getBranches: () -> {
          data:[
            id:15
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
          ]
        }

      $provide.value '$state',
        go: () -> null

      null

  scope = getBranchesSpy = goSpy = undefined
  StoreService = createController = $state = $stateParams = undefined

  beforeEach ->
    inject ($controller, $injector, $rootScope) ->
      StoreService = $injector.get 'StoreService'
      $state = $injector.get '$state'

      getBranchesSpy = spyOn(StoreService, 'getBranches').and.callThrough()
      goSpy = spyOn($state, 'go').and.callThrough()

      scope = $rootScope.$new()
      createController = () ->
        $controller "BranchEditCtrl",
          $scope: scope
          StoreService: StoreService
          $stateParams: {id:15}

  describe "init", ->

    beforeEach ->
      createController()

    it "should call service to get branches data", ->
      expect(getBranchesSpy).toHaveBeenCalled()

    it "should set a branch object in the scope", ->
      expect(scope.branch).toBeDefined()

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
      updateSpy = spyOn(StoreService, 'updateBranch').and.callThrough()
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

      scope.save scope.branch, timeframes

    it "should call service", ->
      expect(updateSpy).toHaveBeenCalled()

    it "should update the hours based on flags", ->
      updatedStore = scope.branch
      updatedStore[0] = [ ['11:00', '18:00'] ]
      updatedStore[1] = scope.branch[1]
      updatedStore[2] = [ ['11:30', '15:00'] ]
      updatedStore[3] = scope.branch[3]
      updatedStore[4] = scope.branch[4]
      updatedStore[5] = scope.branch[5]
      updatedStore[6] = []

      expect(updateSpy).toHaveBeenCalledWith updatedStore

    it "should redirect to the branch list page", ->
      expect(goSpy).toHaveBeenCalledWith 'app.branches'


  describe "cancel", ->

    beforeEach ->
      createController()

    it "should redirect to store details page", ->
      scope.cancel()
      expect(goSpy).toHaveBeenCalledWith 'app.branches'