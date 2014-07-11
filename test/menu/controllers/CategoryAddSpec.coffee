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

    it "should set a variable indicating form has been submitted", ->
      createController {}
      scope.addCategory "my_category"
      expect(scope.formSubmitted).toBeTruthy()

    it "should set a variable with the category name", ->
      createController {}
      scope.addCategory "my_category"
      expect(scope.response_msg).toEqual "my_category"

    it "should handle success response", ->
      pristineSpy = spyOn(scope.categoryAddForm, '$setPristine')

      createController {}
      scope.addCategory "my_category"

      expect(scope.category).toEqual ''
      expect(pristineSpy).toHaveBeenCalled()

    it "should handle error response", ->
      spyOn(StoreService, 'addProductCategory').and.callFake( () -> {error:''})
      createController {}
      scope.addCategory "my_category"

      expect(scope.category).not.toEqual ''