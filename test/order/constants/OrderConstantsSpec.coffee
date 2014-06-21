describe "OrderConstants", ->

  beforeEach ->
    module "MuzzaStore.order"

  describe "ORDER_STATUS", ->

    it "should have 6 fields", ->
      inject (ORDER_STATUS) ->
        status = _.keys ORDER_STATUS.STATUS
        expect(status.length).toBe 7

        expect(status).toContain "NEW"
        expect(status).toContain "IN_PROGRESS"
        expect(status).toContain "READY_PICKUP"
        expect(status).toContain "READY_DELIVERY"
        expect(status).toContain "DELIVERY"
        expect(status).toContain "CLOSED"
        expect(status).toContain "CANCELED"