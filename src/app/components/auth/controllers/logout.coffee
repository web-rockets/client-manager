angular.module 'wr.auth'
  .controller 'AuthLogoutController', (AuthService) ->
    'ngInject'
    AuthService.logout()
