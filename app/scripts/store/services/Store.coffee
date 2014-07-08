angular.module('MuzzaStore.store').service 'StoreService', () ->

  store =
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

  retrieveDetails = () ->
    constructStoreDetails store


  updateStore = (_store) ->
    store = _store


  saveCategory = (categoryDesc) ->
    if store['category'] is undefined
      store['category'] = []

    elementFound = _.find store['category'], (elem) ->
      elem.description.toUpperCase() is categoryDesc.toUpperCase()

    if elementFound is undefined
      idCat = store['category'].length + 1
      store['category'].push {id:idCat,description:categoryDesc,products:[]}
      {
        status: 'ok'
      }
    else
      {
        status: 'NOK'
        msg: 'CATEGORY_ALREADY_REGISTERED'
      }



  saveProduct = (product) ->

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
        product.id = categoryToUpdate.products.length + 1
        categoryToUpdate.products.push product

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
    resultsArray = _.map store.category, (category) ->
      {id:category.id,description:category.description}

    resultsObject = {}

    _.each resultsArray, (elem) ->
      resultsObject[elem.id] = elem.description

    resultsObject


  retrieveProducts = () ->
    store.category



  getDetails: retrieveDetails
  updateStore: updateStore


  #####################
  addProductCategory: saveCategory
  addProduct: saveProduct
  getProductCategories: retrieveProductCategories
  getProducts: retrieveProducts