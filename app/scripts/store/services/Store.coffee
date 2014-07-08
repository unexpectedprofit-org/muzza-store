angular.module('MuzzaStore.store').service 'StoreService', (StoreFirebaseAdapter) ->

  getDayName = (dayOfWeek) ->

    switch parseInt dayOfWeek
      when 0 then return "Domingo"
      when 1 then return "Lunes"
      when 2 then return "Martes"
      when 3 then return "Miercoles"
      when 4 then return "Jueves"
      when 5 then return "Viernes"
      when 6 then return "Sabado"

  processStoreHours = (displayOpenHours) ->

    storeHoursArray = []

    keys = _.keys displayOpenHours

    _.each keys, (key) ->

      dayHours =
        day: getDayName key
        hours: []

      currentDay = displayOpenHours[key]

      _.each currentDay, (currentDayHours) ->
        dayHours.hours.push currentDayHours[0]
        dayHours.hours.push currentDayHours[1]

      storeHoursArray.push dayHours

    storeHoursArray

  constructStoreDetails = (storeElement) ->
    storeElement.hours = processStoreHours storeElement.displayOpenHours
    storeElement



  class RetrieveDetailsResponse
    constructor: (response) ->
      if response.success
        @data = constructStoreDetails response.data
      else
        console.log "ERROR - RetrieveDetailsResponse: " + response.error
        @error = response.error


  class UpdateStoreResponse
    constructor: (response) ->
      if response.success
        @data = response.data
      else
        console.log "ERROR - UpdateStoreResponse: " + response.error
        @error = response.error


  class SaveProductCategoryResponse
    constructor: (response) ->
      if response.success
        @data = response.data
      else
        console.log "ERROR - SaveProductCategoryResponse: " + response.error
        @error = response.error



  class RetrieveProductsResponse
    constructor: (response) ->
      if response.success
        @data = response.data.category
      else
        console.log "ERROR - RetrieveProductsResponse: " + response.error
        @error = response.error



  retrieveDetails = () ->
    new RetrieveDetailsResponse StoreFirebaseAdapter.getStore()

  updateStore = (_store) ->
    new UpdateStoreResponse StoreFirebaseAdapter.updateStore _store

  saveProductCategory = (categoryDesc) ->
    new SaveProductCategoryResponse StoreFirebaseAdapter.addCategory categoryDesc.toUpperCase()




  saveProduct = (product) ->

    store = StoreFirebaseAdapter.getStore()

    categoryToUpdate = _.find store.category, (catElem) ->
      catElem.id is parseInt product.categoryId

    if categoryToUpdate isnt undefined

      found = false
      productFound = undefined

      _.each store['category'], (category) ->

        if !found
          productFound = _.find category.products, (prod) ->
            prod.description.toUpperCase() is product.description.toUpperCase()

          if productFound isnt undefined
            found = true

      if productFound is undefined
        StoreFirebaseAdapter.addProduct()

        response =
          status: 'ok'
      else
        response =
          status: "NOK"
          msg: "PRODUCT_ALREADY_REGISTERED"

    else
      response =
        status: "NOK"
        msg: "no category found"

    response

  retrieveProductCategories = () ->
    store = StoreFirebaseAdapter.getStore()

    if store.success
      resultsArray = _.map store.data.category, (category) ->
        {id:category.id,description:category.description}

      resultsObject = {}

      _.each resultsArray, (elem) ->
        resultsObject[elem.id] = elem.description

      resultsObject
    else
      {}


  retrieveProducts = () ->
    new RetrieveProductsResponse StoreFirebaseAdapter.getStore()



  getDetails: retrieveDetails
  updateStore: updateStore


  #####################
  addProductCategory: saveProductCategory
  addProduct: saveProduct
  getProductCategories: retrieveProductCategories
  getProducts: retrieveProducts