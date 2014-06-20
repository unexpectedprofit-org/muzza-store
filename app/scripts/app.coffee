angular.module('Muzza.controllers',[])



angular.module("Muzza", ['ui.router', 'ionic',
                         'Muzza.templates',
                         'Muzza.controllers'])

angular.module("Muzza").run ($ionicPlatform, $state) ->
  $ionicPlatform.ready ->
    StatusBar.styleDefault() if window.StatusBar
    $state.go 'app.menu'


angular.module("Muzza").config ($stateProvider, $urlRouterProvider) ->
  $stateProvider.state "app",
    url: "/app"
    abstract: true
    templateUrl: "../app/templates/nav.html"

  .state "app.menu",
    url: "/menu"
    views:
      navContent:
        templateUrl: "../app/templates/menu.html"





  # if none of the above states are matched, use this as the fallback
  $urlRouterProvider.otherwise "/app/menu"