angular.module('MuzzaStore.store').service 'StoreFirebaseAdapter', () ->

  company =
    id: 1
    name_real: "La pizzeria de Juancho"

    branches: [
      id:1
      name_fantasy: "Juancho Caballito"
      address:
        street: "Av. Rivadavia"
        door: 5100
        zip: "1406"
        hood: "Caballito"
        area: "Capital Federal"
        state: "Buenos Aires"
      phone:
        main: "44445555"
        other: "11112222"
        cel: "1544449999"
      displayOpenHours:
        0: [ ]
        1: [ ['12:00', '14:00'], ['19:30', '03:00'] ]
        2: [ ['11:30', '15:00'], ['19:30', '22:00'] ]
        3: [ ['11:30', '15:00'], ['19:30', '22:00'] ]
        4: [ ['11:30', '15:00'], ['19:30', '01:00'] ]
        5: [ ['11:30', '15:00'], ['19:30', '02:30'] ]
        6: [ ['18:30', '03:00'] ]
    ,
      id:2
      name_fantasy: "Juancho Boedo II"
      address:
        street: "Av. Juan B. ALberdi"
        door: 2200
        zip: "1405"
        hood: "Boedo"
        area: "Capital Federal"
        state: "Buenos Aires"
      phone:
        main: "99991111"
        other: "33335577"
        cel: "1511110000"
      displayOpenHours:
        0: [ ['18:30', '03:00'] ]
        1: [ ['11:30', '15:00'], ['19:30', '23:00'] ]
        2: [ ['11:30', '15:00'], ['19:30', '23:00'] ]
        3: [ ['11:30', '15:00'], ['19:30', '23:00'] ]
        4: [ ['11:30', '15:00'], ['19:30', '23:00'] ]
        5: [ ['11:30', '15:00'], ['19:30', '23:00'] ]
        6: [ ['20:00', '03:00'] ]
    ]

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

  retrieveProductsByCategory = () ->
    {
      success: true
      data:company.category
    }


  retrieveBranches = () ->
    {
      success: true
      data:company.branches
    }

  saveCategory = (categoryDescription) ->

    if company['category'] is undefined
      company['category'] = []

    elementFound = _.find company['category'], (elem) ->
      elem.description.toUpperCase() is categoryDescription.toUpperCase()

    if elementFound is undefined
      idCat = company['category'].length + 1
      company['category'].push {id:idCat,description:categoryDescription,products:[]}
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
    categoryToUpdate = _.find company.category, (elem) ->
      elem.id is product.categoryId

    product.id = categoryToUpdate.products.length + 1
    categoryToUpdate.products.push product

    {
      success: true
      data: product.description
    }



  getProducts: retrieveProductsByCategory
  getBranches: retrieveBranches

  addCategory: saveCategory
  addProduct: saveProduct