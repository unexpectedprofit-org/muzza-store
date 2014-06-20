describe 'OrderDetails', ->

  beforeEach ->
    module 'MuzzaStore.order'

  OrderDetails = order = hideSpy = showSpy = undefined

  beforeEach ->
    inject ($injector) ->
      OrderDetails = $injector.get 'OrderDetails'
      modal =
        show: -> null
        hide: -> null
        scope:
          orderDetails: {}

      showSpy = spyOn(modal, 'show').and.callThrough()
      hideSpy = spyOn(modal, 'hide').and.callThrough()

      order = new OrderDetails modal

  describe "Init", ->

    it 'should construct a OrderDetails object', ->
      expect(order.show).toBeDefined()
      expect(order.hide).toBeDefined()


  describe "Hide", ->

    it 'should delegate the hide call to the modal', ->
      order.hide()

      expect(hideSpy).toHaveBeenCalled()

  describe "Show", ->

    it 'should delegate the show call to the modal', ->
      order.show()

      expect(showSpy).toHaveBeenCalled()