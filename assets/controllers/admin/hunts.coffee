APP = window.APP
APP.Controllers.controller('AdminHunts', ['$scope', '$routeParams', 'Hunt', ($scope, $routeParams, Hunt) ->
  $scope.init = ->
    $scope.stateId = $routeParams.id
    hunts = Hunt.adminIndex {stateId: $routeParams.id}, ->
      $scope.hunts = hunts

  $scope.init.call(@)
])