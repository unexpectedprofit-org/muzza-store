describe 'Store Firebase Adapter', ->

  beforeEach ->
    module 'MuzzaStore.store'

  StoreFirebaseAdapter = undefined

  beforeEach ->
    inject ($injector) ->
      StoreFirebaseAdapter = $injector.get 'StoreFirebaseAdapter'


  describe "addCategory functionality", ->

    it "should update the store object with the new category - first category", ->

      storedetails = StoreFirebaseAdapter.getProducts().data
      storedetails.category = undefined

      response = StoreFirebaseAdapter.addCategory "my_category"

      expect(response.success).toBeTruthy()
      expect(response.data).toBe "my_category"


    it "should update the store object with the new category - some previous category stored", ->

      storedetails = StoreFirebaseAdapter.getProducts().data
      storedetails['category'] = [
        id:1
        description:"First Category"
      ]

      response = StoreFirebaseAdapter.addCategory "my_other_category"

      storedetails = StoreFirebaseAdapter.getProducts()

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
      storedetails = StoreFirebaseAdapter.getProducts().data
      storedetails.categories = [
        id:1
        description:"First Category"
        products: []
      ]

      product =
        description:"my_product"
        categoryId: storedetails.categories[0].id

      response = StoreFirebaseAdapter.addProduct product

      expect(response.success).toBeTruthy()
      expect(response.data).toEqual product.description


    it "should update the store object with the new product - some previous products stored", ->
      storedetails = StoreFirebaseAdapter.getProducts().data
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


  describe "getBranches functionality", ->

    it "should return a success response", ->
      response = StoreFirebaseAdapter.getBranches()

      expect(response.success).toBeTruthy()
      expect(response.data.length).toBe 2
      expect(response.data[0].name_fantasy).toBe "Juancho Caballito"
      expect(response.data[1].name_fantasy).toBe "Juancho Boedo II"


  describe "getProducts functionality", ->

    it "should return a success response", ->
      response = StoreFirebaseAdapter.getProducts()

      expect(response.success).toBeTruthy()
      expect(response.data.length).toBe 3
      expect(response.data[0].description).toBe "Bebidas"
      expect(response.data[1].description).toBe "Helados"
      expect(response.data[2].description).toBe "Empanadas"