angular.module('MuzzaStore.store').service 'StoreFirebaseAdapter', () ->

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

  retrieveStore = () ->
    {
      success: true
      data: store
    }

  updateStore = (_store) ->
    store = _store
    {
      success: true
      data: store
    }

  saveCategory = (categoryDescription) ->

    if store['category'] is undefined
      store['category'] = []

    elementFound = _.find store['category'], (elem) ->
      elem.description.toUpperCase() is categoryDescription.toUpperCase()

    if elementFound is undefined
      idCat = store['category'].length + 1
      store['category'].push {id:idCat,description:categoryDescription,products:[]}
      {
        success: true
        data: categoryDescription
      }
    else
      {
        success: false
        error: 'CATEGORY_ALREADY_REGISTERED'
      }


  saveProduct = (product) ->
    categoryToUpdate = _.find store.category, (elem) ->
      elem.id is product.categoryId

    product.id = categoryToUpdate.products.length + 1
    categoryToUpdate.products.push product

    {
      success: true
      data: product.description
    }



  getStore: retrieveStore
  updateStore: updateStore

  addCategory: saveCategory
  addProduct: saveProduct