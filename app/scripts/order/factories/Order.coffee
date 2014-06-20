angular.module('MuzzaStore.order').factory 'Order', () ->

  class Order
    constructor: (data) ->
      angular.extend @, data

  return Order