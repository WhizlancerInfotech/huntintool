APP = window.APP
APP.Controllers.controller('HuntsNevadaSilverStateElk', ['$scope', ($scope) ->
  $scope.init = ->
    $scope.setHuntType '{"type": "ctl00$ContentPlaceHolder1$gvAppType$ctl18$grbAppType"}'

  $scope.init.call(@)
])
