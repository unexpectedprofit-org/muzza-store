angular.module('MuzzaStore.order',[])
angular.module('MuzzaStore.store',[])



angular.module("MuzzaStore", ['ui.router', 'ionic',
                              'MuzzaStore.templates',
                              'MuzzaStore.order',
                              'MuzzaStore.store'])

angular.module("MuzzaStore").run ($ionicPlatform, $state) ->
  $ionicPlatform.ready ->
    StatusBar.styleDefault() if window.StatusBar
    $state.go 'app.orders-list'


angular.module("MuzzaStore").config ($stateProvider, $urlRouterProvider) ->
  $stateProvider.state "app",
    url: "/app"
    abstract: true
    templateUrl: "../app/templates/nav.html"

  .state "app.menu",
    url: "/menu"
    views:
      navContent:
        templateUrl: "../app/templates/menu.html"


  .state "app.store-details",
    url: "/store/details"
    views:
      navContent:
        templateUrl: "../app/scripts/store/templates/store-details-view.html"

  .state "app.store-edit",
    url: "/store/edit"
    views:
      navContent:
        templateUrl: "../app/scripts/store/templates/store-edit.html"
        controller: "StoreEditCtrl"

  .state "app.orders-list",
    url: "/orders/list"
    views:
      navContent:
        templateUrl: "../app/scripts/order/templates/orders-list.html"
        controller: "OrderList"





  # if none of the above states are matched, use this as the fallback
  $urlRouterProvider.otherwise "/app/menu"