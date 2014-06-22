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

  retrieveDetails = () ->
    store

  updateStore = (_store) ->
    store = _store



  getDetails: retrieveDetails
  updateStore: updateStore