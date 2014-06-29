describe "Category Add Controller", ->

  beforeEach ->
    module "MuzzaStore.product"
    module "MuzzaStore.store"

  scope = rootScope = addCategorySpy = undefined
  createController = StoreService = undefined

  beforeEach ->
    module ($provide) ->
      $provide.value 'StoreService',
        addProductCategory: () -> {status:'ok'}
      null

  beforeEach ->
    inject ($controller, $rootScope, $injector) ->
      StoreService = $injector.get 'StoreService'
      rootScope = $rootScope
      scope = $rootScope.$new()
      scope.categoryAddForm =
        $setPristine: () -> null

      createController = () ->
        $controller "CategoryAddCtrl",
          $scope: scope
          StoreService: StoreService

  describe "init", ->

    it "should have functions defined", ->
      createController {}
      expect(scope.addCategory).toBeDefined()


  describe "addCategory functionality", ->

    it "should call the service", ->
      addCategorySpy = spyOn(StoreService, 'addProductCategory').and.callThrough()
      createController {}
      scope.addCategory "my_category"
      expect(addCategorySpy).toHaveBeenCalledWith "my_category"
      expect(scope.response).toBeDefined()

    it "should handle success response", ->
      pristineSpy = spyOn(scope.categoryAddForm, '$setPristine')

      createController {}
      scope.addCategory "my_category"

      expect(scope.response.msg).toEqual( "La categoria '" + "my_category" + "' ha sido creada con exito!" )
      expect(scope.category).toEqual ''
      expect(pristineSpy).toHaveBeenCalled()

    it "should handle error response", ->
      spyOn(StoreService, 'addProductCategory').and.callFake( () -> {status:'NOK'})
      createController {}
      scope.addCategory "my_category"

      expect(scope.response.msg).toEqual( "Se ha producido un error al intentar crear la categoria '" + "my_category" + "'" )
      expect(scope.category).not.toEqual ''