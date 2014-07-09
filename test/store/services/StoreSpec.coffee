describe 'Store Service', ->

  beforeEach ->
    module 'MuzzaStore.store'
    module ($provide) ->
      $provide.value 'StoreFirebaseAdapter',
        getBranches: () -> {success:true,data:{}}
        getProducts: () -> {success:true,data:{}}
        updateStore: () -> {success:true,data:{}}
        addProduct: () -> {success:true,data:{}}
        addCategory: () -> {success:true,data:{}}
      null

  StoreService = StoreFirebaseAdapter = undefined

  beforeEach ->
    inject ($injector) ->
      StoreService = $injector.get 'StoreService'
      StoreFirebaseAdapter = $injector.get 'StoreFirebaseAdapter'

  describe 'init', ->

    it "should have functions define", ->
      expect(StoreService.getProducts).toBeDefined()
      expect(StoreService.getProductCategories).toBeDefined()
      expect(StoreService.addProduct).toBeDefined()
      expect(StoreService.addProductCategory).toBeDefined()
      expect(StoreService.updateStore).toBeDefined()
      expect(StoreService.getBranches).toBeDefined()


  describe "getBranches functionality", ->

    it "should call adapter", ->
      getStoreSpy = spyOn(StoreFirebaseAdapter, 'getBranches').and.callThrough()
      StoreService.getBranches()

      expect(getStoreSpy).toHaveBeenCalled()

    it "should handle success response: construct hours field", ->
      hours =
        0: [ ]
        1: [ ['12:00', '14:00'], ['19:30', '03:00'] ]
        2: [ ['11:30', '15:00'], ['19:30', '22:00'] ]
        3: [ ['11:30', '15:00'], ['19:30', '22:00'] ]
        4: [ ['11:30', '15:00'], ['19:30', '01:00'] ]
        5: [ ['11:30', '15:00'], ['19:30', '02:30'] ]
        6: [ ['18:30', '03:00'] ]

      fakeResponse =
        success: true
        data: [{displayOpenHours: hours}]

      spyOn(StoreFirebaseAdapter, 'getBranches').and.callFake( () -> fakeResponse )
      response = StoreService.getBranches()

      expectedHours = [
        day: "Domingo"
        hours:   [ ]
      ,
        day: "Lunes"
        hours:     [ "12:00", "14:00", "19:30", "03:00" ]
      ,
        day: "Martes"
        hours:    [ "11:30", "15:00", "19:30", "22:00" ]
      ,
        day: "Miercoles"
        hours: [ "11:30", "15:00", "19:30", "22:00" ]
      ,
        day: "Jueves"
        hours:    [ "11:30", "15:00", "19:30", "01:00" ]
      ,
        day: "Viernes"
        hours:   [ "11:30", "15:00", "19:30", "02:30" ]
      ,
        day: "Sabado"
        hours:    [ "18:30", "03:00" ]
      ]

      expect(response.data).toBeDefined()
      expect(response.error).toBeUndefined()
      expect(response.data[0].hours).toEqual expectedHours

    it "should handle error response", ->
      fakeErrorResponse =
        success: false
        error: "alal"

      spyOn(StoreFirebaseAdapter, 'getBranches').and.callFake( () -> fakeErrorResponse )
      response = StoreService.getBranches()

      expect(response.success).toBeFalsy()
      expect(response.data).toBeUndefined()
      expect(response.error).toBeDefined()


  describe "updateStore functionality", ->

    it "should call adapter", ->
      updateStoreSpy = spyOn(StoreFirebaseAdapter, 'updateStore').and.callThrough()
      StoreService.updateStore()

      expect(updateStoreSpy).toHaveBeenCalled()


  describe "addProductCategory functionality", ->

    it "should call the adapter", ->
      addCategorySpy = spyOn(StoreFirebaseAdapter, 'addCategory').and.callThrough()
      StoreService.addProductCategory ""

      expect(addCategorySpy).toHaveBeenCalled()

    it "should handle success response", ->
      fakeResponse =
        success: true
        data: {some:"thing"}

      spyOn(StoreFirebaseAdapter, 'addCategory').and.callFake( () -> fakeResponse )
      response = StoreService.addProductCategory ""
      expect(response.data).toBeDefined()
      expect(response.error).toBeUndefined()


    it "should handle error reponse", ->
      fakeErrorResponse =
        success: false
        error: "jojojo"

      spyOn(StoreFirebaseAdapter, 'addCategory').and.callFake( () -> fakeErrorResponse )
      response = StoreService.addProductCategory ""
      expect(response.data).toBeUndefined()
      expect(response.error).toBeDefined()



  describe "addProduct functionality", ->

    it "should call the adapter", ->
      getStoreSpy = spyOn(StoreFirebaseAdapter, 'getProducts').and.callThrough()
      StoreService.addProduct()

      expect(getStoreSpy).toHaveBeenCalled()


    it "should NOT call the adapter to add product if no category found", ->
      fakeStore =
        category: [
          id:1
          description:"First Category"
          products: [{id:1,description:"holahola"}]
        ]

      spyOn(StoreFirebaseAdapter, 'getProducts').and.callFake( () -> {success:true,data:fakeStore} )
      addProductSpy = spyOn(StoreFirebaseAdapter, 'addProduct').and.callThrough()

      product =
        description:"my_new_product"
        categoryId: 9

      StoreService.addProduct product

      expect(addProductSpy).not.toHaveBeenCalled()


    it "should NOT call the adapter if already stored", ->
      product =
        description: "my_product"
        categoryId: 1

      addProductSpy = spyOn(StoreFirebaseAdapter, 'addProduct').and.callThrough()

      StoreService.addProduct product

      expect(addProductSpy).not.toHaveBeenCalled()


  describe "getProductCategories functionality", ->

    it "should call the adapter", ->
      getStoreSpy = spyOn(StoreFirebaseAdapter, 'getProducts').and.callThrough()
      StoreService.getProductCategories()

      expect(getStoreSpy).toHaveBeenCalled()


    it "should get an object of product categories containing only id/description fields", ->
      fakeResponse =
        success:true
        data:[
          id:1
          description:"First Category"
          products: []
        ]


      spyOn(StoreFirebaseAdapter, 'getProducts').and.callFake( () -> fakeResponse )
      response = StoreService.getProductCategories()

      expect(response["1"]).toEqual 'First Category'


  describe "getProducts functionality", ->

    it "should call adapter", ->
      getStoreSpy = spyOn(StoreFirebaseAdapter, 'getProducts').and.callThrough()
      StoreService.getProducts()

      expect(getStoreSpy).toHaveBeenCalled()

    it "should return the catories array of the store", ->
      fakeResponse =
        success:true,
        data: [
          id:1
          description:"My Category 1"
          products:[]
        ,
          id:2
          description:"My Category 2"
          products:[{id:1},{id:22}]
        ]
      spyOn(StoreFirebaseAdapter, 'getProducts').and.callFake( () -> fakeResponse )
      response = StoreService.getProducts()

      expect(response.data).toEqual fakeResponse.data