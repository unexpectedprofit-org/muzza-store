describe "Product Add Controller", ->

  beforeEach ->
    module "MuzzaStore.product"
    module "MuzzaStore.store"

  scope = rootScope = undefined
  createController = StoreService = undefined

  beforeEach ->
    module ($provide) ->
      $provide.value 'StoreService',
        addProduct: () -> {success:true}
        getProductCategories: () -> {}
      null

  beforeEach ->
    inject ($controller, $rootScope, $injector) ->
      StoreService = $injector.get 'StoreService'
      rootScope = $rootScope
      scope = $rootScope.$new()
      scope.productAddForm =
        $setPristine: () -> null

      createController = () ->
        $controller "ProductAddCtrl",
          $scope: scope
          StoreService: StoreService

  describe "init", ->

    it "should have functions defined", ->
      createController {}
      expect(scope.addProduct).toBeDefined()

    it "should have variables defined", ->
      createController {}
      expect(scope.options).toEqual ['SINGLE', 'MULTIPLE']
      expect(scope.categories).toBeDefined()
      expect(scope.product).toEqual {options: []}

  describe "addProduct functionality", ->

    it "should call the service", ->
      addProductSpy = spyOn(StoreService, 'addProduct').and.callThrough()
      createController {}
      myProduct =
        id:1

      scope.addProduct myProduct
      expect(addProductSpy).toHaveBeenCalledWith myProduct

    it "should set a variable indicating form has been submitted", ->
      createController {}

      scope.addProduct {}
      expect(scope.formSubmitted).toBeTruthy()

    it "should set a variable with the product name", ->
      createController {}
      scope.addProduct {description:"my_product"}
      expect(scope.response_msg).toEqual "my_product"

    it "should handle success response", ->
      pristineSpy = spyOn(scope.productAddForm, '$setPristine').and.callThrough()

      createController {}
      scope.product =
        id:1
        description: "my_product"
      scope.addProduct scope.product

      expect(scope.product).toEqual {options:[]}
      expect(pristineSpy).toHaveBeenCalled()

    it "should handle error response", ->
      spyOn(StoreService, 'addProduct').and.callFake( () -> {error:''})
      createController {}
      scope.product =
        id:1
        description: "my_product"
      scope.addProduct scope.product

      expect(scope.product).not.toEqual {options:[]}

  describe "getProductCategories functionality", ->

    it "should call the service", ->
      getSpy = spyOn(StoreService, 'getProductCategories').and.callThrough()
      createController {}

      expect(getSpy).toHaveBeenCalled()
      expect(scope.categories).toEqual {}
