describe 'BranchDetails directive', ->

  beforeEach ->
    module 'MuzzaStore.store'
    module 'MuzzaStore.templates'

    module ($provide) ->
      $provide.value '$state',
        go: () -> null

      $provide.value 'StoreService',
        getBranches: () -> {data:{}}
      null

  element = isolatedScope = $scope = $state = StoreService = undefined

  beforeEach ->
    inject ($rootScope, $compile, $injector) ->
      $state = $injector.get '$state'
      StoreService = $injector.get 'StoreService'

      spyOn(StoreService, 'getBranches').and.callThrough()


      $scope = $rootScope
      element = angular.element('<branch-details></branch-details>')
      $compile(element)($rootScope)
      $scope.$digest()
      isolatedScope = element.isolateScope()

  describe "init", ->

    it "should have functions defined", ->
      expect(isolatedScope.edit).toBeDefined()

    it "should have a store object defined", ->
      expect(isolatedScope.branches).toBeDefined()


  describe "edit functionality", ->

    it "should call go on state", ->
      goSpy = spyOn($state, 'go')
      isolatedScope.edit 15
      expect(goSpy).toHaveBeenCalledWith 'app.branch-edit', {id:15}

    it "should call go on state", ->
      goHoursSpy = spyOn($state, 'go')
      isolatedScope.edit 99, 'hours'
      expect(goHoursSpy).toHaveBeenCalledWith 'app.branch-edit-hours', {id:99}


