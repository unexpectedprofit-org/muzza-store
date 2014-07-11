describe 'Store Firebase Adapter', ->

  beforeEach ->
    module 'MuzzaStore.store'

  StoreFirebaseAdapter = undefined

  beforeEach ->
    inject ($injector) ->
      StoreFirebaseAdapter = $injector.get 'StoreFirebaseAdapter'


  describe "addCategory functionality", ->

    it "should update the store object with the new category", ->

      response = StoreFirebaseAdapter.addCategory "my_other_category"
      expect(response.success).toBeTruthy()
      expect(response.data).toBe "my_other_category"

      expect(StoreFirebaseAdapter.getProducts().data.length).toBe 4


    it "should NOT store the category if already stored", ->
      #first attempt - store non existing category
      response = StoreFirebaseAdapter.addCategory "milanesas"
      expect(response.success).toBeTruthy()
      expect(response.data).toEqual "milanesas"

      prodByCategories = StoreFirebaseAdapter.getProducts().data
      expect(prodByCategories[prodByCategories.length - 1].description).toBe "milanesas"

      #second attempt - store existing category
      response = StoreFirebaseAdapter.addCategory "MILANESAS"
      expect(response.success).toBeFalsy()
      expect(response.error).toEqual "CATEGORY_ALREADY_REGISTERED"


  describe "addProduct functionality", ->

    it "should update the store object with the new product", ->
      product =
        description:"my_product"
        categoryId: 1

      response = StoreFirebaseAdapter.addProduct product
      expect(response.success).toBeTruthy()
      expect(response.data).toEqual product.description

      expect(StoreFirebaseAdapter.getProducts().data[0].products.length).toBe 1


    it "should NOT store the product if already stored", ->
      product =
        description:"my_new_product"
        categoryId: 2

      #first attempt - store non existing product
      response = StoreFirebaseAdapter.addProduct product
      expect(response.success).toBeTruthy()
      expect(response.data).toEqual product.description

      prodByCategories = StoreFirebaseAdapter.getProducts().data
      expect(prodByCategories[1].products.length).toBe 1

      #second attempt - store existing product
      response = StoreFirebaseAdapter.addProduct product
      expect(response.success).toBeFalsy()
      expect(response.error).toEqual "PRODUCT_ALREADY_REGISTERED"

      prodByCategories = StoreFirebaseAdapter.getProducts().data
      expect(prodByCategories[1].products.length).toBe 1




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