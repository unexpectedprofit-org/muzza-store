angular.module('MuzzaStore.order',[])
angular.module('MuzzaStore.store',[])
angular.module('MuzzaStore.product',[])



angular.module("MuzzaStore", ['ui.router', 'ionic',
                              'MuzzaStore.templates',
                              'MuzzaStore.order',
                              'MuzzaStore.store',
                              'MuzzaStore.product'
])

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

  .state "app.product-cat-add",
    url: "/products/category/add"
    views:
      navContent:
        templateUrl: "../app/scripts/product/templates/menu-category-add.html"

  .state "app.product-add",
    url: "/products/add"
    views:
      navContent:
        templateUrl: "../app/scripts/product/templates/menu-product-add.html"

  .state "app.products-list",
    url: "/products"
    views:
      navContent:
        templateUrl: "../app/scripts/product/templates/menu-products.html"
        controller: "ProductListCtrl"

  .state "app.branches",
    url: "/branches"
    views:
      navContent:
        templateUrl: "../app/scripts/store/templates/branches-list.html"

  .state "app.branch-edit",
    url: "/branches/edit/:id"
    views:
      navContent:
        templateUrl: "../app/scripts/store/templates/branch-edit.html"
        controller: "BranchEditCtrl"

  .state "app.branch-edit-hours",
    url: "/branches/editHours/:id"
    views:
      navContent:
        templateUrl: "../app/scripts/store/templates/branch-edit-hours.html"
        controller: "BranchEditCtrl"

  .state "app.orders-list",
    url: "/orders/list"
    views:
      navContent:
        templateUrl: "../app/scripts/order/templates/orders-list.html"
        controller: "OrderList"





  # if none of the above states are matched, use this as the fallback
  $urlRouterProvider.otherwise "/app/menu"