angular.module('MuzzaStore.store').directive 'branchDetails', (StoreService, $state) ->
  restrict: 'EA'
  scope: {
  }
  templateUrl: '../app/scripts/store/templates/branch-details.html'

  link: ($scope, ele, attrs, ctrl) ->

    $scope.branches = StoreService.getBranches().data

    $scope.edit = (branchId, what) ->
      if what is 'hours'
        $state.go 'app.branch-edit-hours', {id:branchId}
      else
        $state.go 'app.branch-edit', {id:branchId}
