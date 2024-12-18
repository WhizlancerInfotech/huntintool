APP = window.APP
APP.Controllers.controller('AdminEmailsPoints', ['$scope', '$routeParams', '$location', 'TenantEmail', 'User', ($scope, $routeParams, $location, TenantEmail, User) ->

  $scope.init = ->
    $scope.tenant = window.tenant
    email = TenantEmail.adminByType {type: 'Points'}, ->
      if email?._id
        $scope.email = email
      else
        $scope.email = {
          type: 'Points'
          enabled: false
        }

    $scope.getTestUsers()


  $scope.getTestUsers = () ->
    User.testUsers {tenantId: $scope.tenant._id}, (rsp) ->
      #success
      for testUser in rsp
        testUser.displayName = "#{testUser.first_name} #{testUser.last_name}"
        testUser.displayName += " - #{testUser.clientId}" if testUser.clientId
      $scope.testUsersOptions = rsp
    ,
      (err) ->
        console.log "Failed to get list of test users. Error: ", err


  $scope.submit = (email) ->
    method = 'adminSave'
    if email._id
      method = 'adminUpdate'
    TenantEmail[method] email, ->
      alert 'Email template saved'
      $location.path '/admin/emails'
      $scope.redraw()


  $scope.sendTestEmail = (email) ->
    testUser = ""
    for tUser in $scope.testUsersOptions
      testUser = tUser if tUser._id is email.testUserId

    result = confirm "Confirm sending test email to #{testUser.email}, clientId: #{testUser.clientId}"
    if result
      params = {
        userId: email.testUserId
        tenantEmailId: email._id
        sendAsTest: true
        task: "points_email.send"
      }
      TenantEmail.adminSendTest params, (rsp) ->
        alert "Points email test sent successfully"
      ,
        (err) ->
          if err.error
            msg = "Test email failed to send with error " + err.error
          else
            msg = "Test email failed to send with error " + err
          alert msg

  $scope.sendAll = (email) ->
    alert "Sending to all users is currently disabled.  Please contact support@gotmytag.com to request enabling this feature. thanks."


  $scope.init.call(@)
])
