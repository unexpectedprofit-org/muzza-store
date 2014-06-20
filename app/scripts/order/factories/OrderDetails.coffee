angular.module('MuzzaStore.order').factory 'OrderDetails', () ->

  class OrderDetails
    constructor: (modal) ->
      @modal = modal


  OrderDetails::show = () ->
    @modal.show()

  OrderDetails::hide = () ->
    @modal.hide()

  return OrderDetails