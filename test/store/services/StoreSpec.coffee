describe 'Store Service', ->

  beforeEach ->
    module 'MuzzaStore.store'

  StoreService = undefined

  beforeEach ->
    inject ($injector) ->
      StoreService = $injector.get 'StoreService'

  describe 'init', ->

    it "should have functions define", ->

      expect(StoreService.getDetails).toBeDefined()

  describe "getDetails functionality", ->

    it "should retrieve details", ->

      expect(StoreService.getDetails().name_fantasy).toBe "La pizzeria de Juancho"

  describe "updateStore functionality", ->

    it "should update the store info", ->

      store1 = angular.copy StoreService.getDetails()

      store1.name_fantasy = "My new fantasy name"

      StoreService.updateStore store1

      expect(StoreService.getDetails().name_fantasy).toBe 'My new fantasy name'

  describe "addProductCategory", ->

    it "should update the store object with the new category - first category", ->

      storedetails = StoreService.getDetails()
      storedetails.category = undefined

      response = StoreService.addProductCategory "my_category"

      expect(response.status).toBe 'ok'
      expect(StoreService.getDetails().category[0].id).toBe 1
      expect(StoreService.getDetails().category[0].description).toBe 'my_category'


    it "should update the store object with the new category - some previous category stored", ->

      storedetails = StoreService.getDetails()
      storedetails['category'] = [
        id:1
        description:"First Category"
      ]

      response = StoreService.addProductCategory "my_other_category"

      StoreService.getDetails()

      expect(response.status).toBe 'ok'
      expect(StoreService.getDetails().category[1].id).toBe 2
      expect(StoreService.getDetails().category[1].description).toBe 'my_other_category'


  describe "addProduct functionality", ->

    it "should update the store object with the new product - first product", ->
      storedetails = StoreService.getDetails()
      storedetails['category'] = [
        id:1
        description:"First Category"
        products: []
      ]

      product =
        description:"my_product"
        categoryId: storedetails['category'][0].id

      response = StoreService.addProduct product

      expect(response.status).toBe 'ok'
      expect(StoreService.getDetails().category[0].products.length).toBe 1
      expect(StoreService.getDetails().category[0].products[0]).toEqual product


    it "should update the store object with the new product - some previous products stored", ->
      storedetails = StoreService.getDetails()
      storedetails['category'] = [
        id:1
        description:"First Category"
        products: [{id:1,description:"holahola"}]
      ]

      product =
        description:"my_new_product"
        categoryId: storedetails['category'][0].id

      response = StoreService.addProduct product

      expect(response.status).toBe 'ok'
      expect(StoreService.getDetails().category[0].products.length).toBe 2
      expect(StoreService.getDetails().category[0].products[1]).toEqual product

    it "should NOT update the store object with the new product if no catgory found", ->
      storedetails = StoreService.getDetails()
      storedetails['category'] = [
        id:1
        description:"First Category"
        products: [{id:1,description:"holahola"}]
      ]

      product =
        description:"my_new_product"
        categoryId: 9

      response = StoreService.addProduct product

      expect(response.status).toBe 'NOK'
      expect(StoreService.getDetails().category[0].products.length).toBe 1


  describe "getProductCategories functionality", ->

    it "should get an array of product categories containing only id/description fields", ->
      storedetails = StoreService.getDetails()
      storedetails['category'] = [
        id:1
        description:"First Category"
        products: []
      ]

      response = StoreService.getProductCategories()

      expect(response["1"]).toEqual 'First Category'