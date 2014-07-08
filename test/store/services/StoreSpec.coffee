describe 'Store Service', ->

  beforeEach ->
    module 'MuzzaStore.store'
    module ($provide) ->
      $provide.value 'StoreFirebaseAdapter',
        getStore: () -> {success:true,data:{}}
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

      expect(StoreService.getDetails).toBeDefined()


  describe "getDetails functionality", ->

    it "should call adapter", ->
      getStoreSpy = spyOn(StoreFirebaseAdapter, 'getStore').and.callThrough()
      StoreService.getDetails()

      expect(getStoreSpy).toHaveBeenCalled()

    it "should construct hours field", ->
      fakeStore =
        displayOpenHours:
          0: [ ]
          1: [ ['12:00', '14:00'], ['19:30', '03:00'] ]
          2: [ ['11:30', '15:00'], ['19:30', '22:00'] ]
          3: [ ['11:30', '15:00'], ['19:30', '22:00'] ]
          4: [ ['11:30', '15:00'], ['19:30', '01:00'] ]
          5: [ ['11:30', '15:00'], ['19:30', '02:30'] ]
          6: [ ['18:30', '03:00'] ]

      spyOn(StoreFirebaseAdapter, 'getStore').and.callFake( () -> {success:true,data:fakeStore} )
      response = StoreService.getDetails()

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

      expect(response.data.hours).toEqual expectedHours


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


  describe "addProduct functionality", ->

    it "should call the adapter", ->
      getStoreSpy = spyOn(StoreFirebaseAdapter, 'getStore').and.callThrough()
      StoreService.addProduct()

      expect(getStoreSpy).toHaveBeenCalled()


    it "should call the adapter - first product", ->
      fakeStore =
        category: [
          id:1
          description:"First Category"
          products: []
        ]

      spyOn(StoreFirebaseAdapter, 'getStore').and.callFake( () -> fakeStore )
      addProductSpy = spyOn(StoreFirebaseAdapter, 'addProduct').and.callThrough()

      product =
        description:"my_product"
        categoryId: fakeStore.category[0].id

      StoreService.addProduct product

      expect(addProductSpy).toHaveBeenCalled()


    it "should NOT call the adapter to add product if no category found", ->
      fakeStore =
        category: [
          id:1
          description:"First Category"
          products: [{id:1,description:"holahola"}]
        ]

      spyOn(StoreFirebaseAdapter, 'getStore').and.callFake( () -> fakeStore )
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
      getStoreSpy = spyOn(StoreFirebaseAdapter, 'getStore').and.callThrough()
      StoreService.getDetails()

      expect(getStoreSpy).toHaveBeenCalled()


    it "should get an array of product categories containing only id/description fields", ->
      fakeStore =
        category: [
          id:1
          description:"First Category"
          products: []
        ]

      spyOn(StoreFirebaseAdapter, 'getStore').and.callFake( () -> {success:true,data:fakeStore} )
      response = StoreService.getProductCategories()

      expect(response["1"]).toEqual 'First Category'


  describe "getProducts functionality", ->

    it "should call adapter", ->
      getStoreSpy = spyOn(StoreFirebaseAdapter, 'getStore').and.callThrough()
      StoreService.getProducts()

      expect(getStoreSpy).toHaveBeenCalled()

    it "should return the catories array of the store", ->
      fakeStore =
        category: [
          id:1
          description:"My Category 1"
        ,
          id:2
          description:"My Category 2"
        ]
      spyOn(StoreFirebaseAdapter, 'getStore').and.callFake( () -> {success:true,data:fakeStore } )
      response = StoreService.getProducts()

      expect(response.data).toEqual fakeStore.category