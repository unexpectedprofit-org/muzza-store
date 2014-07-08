describe 'Store Firebase Adapter', ->

  beforeEach ->
    module 'MuzzaStore.store'

  StoreFirebaseAdapter = undefined

  beforeEach ->
    inject ($injector) ->
      StoreFirebaseAdapter = $injector.get 'StoreFirebaseAdapter'

  describe "getStore functionality", ->

    it "should retrieve store", ->
      response = StoreFirebaseAdapter.getStore()

      expectedStore =
        id: 1,
        name_real: "Juancho S.R.L.",
        name_fantasy: "La pizzeria de Juancho",

        address:
          street: "Av. Rivadavia",
          door: 5100,
          zip: "1406",
          hood: "Caballito",
          area: "Capital Federal",
          state: "Buenos Aires"

        phone:
          main: "44445555",
          other: "11112222",
          cel: "1544449999"

        displayOpenHours:
          0: [ ]
          1: [ ['12:00', '14:00'], ['19:30', '03:00'] ]
          2: [ ['11:30', '15:00'], ['19:30', '22:00'] ]
          3: [ ['11:30', '15:00'], ['19:30', '22:00'] ]
          4: [ ['11:30', '15:00'], ['19:30', '01:00'] ]
          5: [ ['11:30', '15:00'], ['19:30', '02:30'] ]
          6: [ ['18:30', '03:00'] ]

        order:
          minPrice:
            delivery: 6000
            pickup: 8000

        category: [
          id:1
          description:"Bebidas"
          products: []
        ,
          id:2
          description:"Helados"
          products: []
        ,
          id:3
          description:"Empanadas"
          products: []

        ]

      expect(response.success).toBeTruthy()
      expect(response.data).toEqual expectedStore


  describe "updateStore functionality", ->

    it "should update the store info", ->
      store1 = angular.copy StoreFirebaseAdapter.getStore()
      store1.name_fantasy = "My new fantasy name"
      StoreFirebaseAdapter.updateStore store1

      response = StoreFirebaseAdapter.getStore()

      expect(response.success).toBeTruthy()
      expect(response.data.name_fantasy).toBe 'My new fantasy name'


  describe "addCategory functionality", ->

    it "should update the store object with the new category - first category", ->

      storedetails = StoreFirebaseAdapter.getStore()
      storedetails.category = undefined

      response = StoreFirebaseAdapter.addCategory "my_category"

      expect(response.success).toBeTruthy()
      expect(response.data).toBe "my_category"


    it "should update the store object with the new category - some previous category stored", ->

      storedetails = StoreFirebaseAdapter.getStore()
      storedetails['category'] = [
        id:1
        description:"First Category"
      ]

      response = StoreFirebaseAdapter.addCategory "my_other_category"

      storedetails = StoreFirebaseAdapter.getStore()

      expect(response.success).toBeTruthy()
      expect(response.data).toBe "my_other_category"

    it "should NOT store the category if already stored", ->
      response = StoreFirebaseAdapter.addCategory "bebidas"

      expect(response.success).toBeFalsy()
      expect(response.error).toBe 'CATEGORY_ALREADY_REGISTERED'

      response = StoreFirebaseAdapter.addCategory "BEBIDAS"

      expect(response.success).toBeFalsy()
      expect(response.error).toBe 'CATEGORY_ALREADY_REGISTERED'

      response = StoreFirebaseAdapter.addCategory "BeBIdAs"

      expect(response.success).toBeFalsy()
      expect(response.error).toBe 'CATEGORY_ALREADY_REGISTERED'


  describe "addProduct functionality", ->

    it "should update the store object with the new product - first product", ->
      storedetails = StoreFirebaseAdapter.getStore()
      storedetails['category'] = [
        id:1
        description:"First Category"
        products: []
      ]

      product =
        description:"my_product"
        categoryId: storedetails['category'][0].id

      response = StoreFirebaseAdapter.addProduct product

      expect(response.success).toBeTruthy()
      expect(response.data).toEqual product.description


    it "should update the store object with the new product - some previous products stored", ->
      storedetails = StoreFirebaseAdapter.getStore()
      storedetails['category'] = [
        id:1
        description:"First Category"
        products: [{id:1,description:"holahola"}]
      ]

      product =
        description:"my_new_product"
        categoryId: storedetails['category'][0].id

      response = StoreFirebaseAdapter.addProduct product

      expect(response.success).toBeTruthy()
      expect(response.data).toEqual product.description