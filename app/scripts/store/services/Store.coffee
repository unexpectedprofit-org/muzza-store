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
      main: "4444 5555",
      other: "1111 2222",
      cel: "15 4444 9999"

    hours:
      0: [undefined,undefined],
      1: [{start:"12:00",end:"14:00"},{start:"19:30",end:"03:00"}],
      2: [{start:"11:30",end:"15:00"},{start:"19:30",end:"22:00"}],
      3: [{start:"11:30",end:"15:00"},{start:"19:30",end:"22:00"}],
      4: [{start:"11:30",end:"15:00"},{start:"19:30",end:"01:00"}],
      5: [{start:"11:30",end:"15:00"},{start:"19:30",end:"02:30"}],
      6: [undefined,{start:"18:30",end:"23:59"}]

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

  retrieveDetails = () ->
    store

  updateStore = (_store) ->
    store = _store


  saveCategory = (categoryDesc) ->
    if store['category'] is undefined
      store['category'] = []

    idCat = store['category'].length + 1

    elementFound = _.find store['category'], (elem) ->
      elem.description.toUpperCase() is categoryDesc.toUpperCase()

    if elementFound is undefined
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
      product.id = categoryToUpdate.products.length + 1
      categoryToUpdate.products.push product

      response =
        status: 'ok'

    else
      response =
        status: "NOK"
        error: "no category found"

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