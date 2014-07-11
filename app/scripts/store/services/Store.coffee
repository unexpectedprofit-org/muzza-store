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

  constructStoreDetails = (storeBranches) ->
    _.forEach storeBranches, (branch) ->
      branch.hours = processStoreHours branch.displayOpenHours

    storeBranches



  class RetrieveBranchesResponse
    constructor: (response) ->
      if response.success
        @data = constructStoreDetails response.data

      else
        console.log "ERROR - RetrieveDetailsResponse: " + response.error
        @error = response.error


  class UpdateBranchResponse
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
        @data = response.data
      else
        console.log "ERROR - RetrieveProductsResponse: " + response.error
        @error = response.error


  class SaveProductResponse
    constructor: (response) ->
      if response.success
        @data = response.data
      else
        console.log "ERROR - SaveProductResponse: " + response.error
        @error = response.error



  retrieveBranches = () ->
    new RetrieveBranchesResponse StoreFirebaseAdapter.getBranches()

  updateBranch = (_store) ->
    new UpdateBranchResponse StoreFirebaseAdapter.updateBranch _store

  saveProductCategory = (categoryDesc) ->
    new SaveProductCategoryResponse StoreFirebaseAdapter.addCategory categoryDesc

  saveProduct = (product) ->
    new SaveProductResponse StoreFirebaseAdapter.addProduct product



  # get an object of categories - {id: description}
  # used for populating select box while adding new product
  retrieveProductCategories = () ->
    store = StoreFirebaseAdapter.getProducts()

    if store.success
      resultsArray = _.map store.data, (category) ->
        {id:category.id,description:category.description}

      resultsObject = {}

      _.each resultsArray, (elem) ->
        resultsObject[elem.id] = elem.description

      resultsObject
    else
      {}


  retrieveProducts = () ->
    new RetrieveProductsResponse StoreFirebaseAdapter.getProducts()



  getBranches: retrieveBranches
  updateBranch: updateBranch


  #####################
  addProductCategory: saveProductCategory
  addProduct: saveProduct
  getProductCategories: retrieveProductCategories
  getProducts: retrieveProducts