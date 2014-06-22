describe 'Store Service', ->

  beforeEach ->
    module 'MuzzaStore.store'

  StoreService = undefined

  beforeEach ->
    inject ($injector) ->
      StoreService = $injector.get 'StoreService'

  describe 'init', ->

    it "should have functions define", ->

      expect(StoreService.getDetails).toBeDefined()

  describe "getDetails functionality", ->

    it "should retrieve details", ->

      expect(StoreService.getDetails().name_fantasy).toBe "La pizzeria de Juancho"

  describe "updateStore functionality", ->

    it "should update the store info", ->

      store1 = angular.copy StoreService.getDetails()

      store1.name_fantasy = "My new fantasy name"

      StoreService.updateStore store1

      expect(StoreService.getDetails().name_fantasy).toBe 'My new fantasy name'