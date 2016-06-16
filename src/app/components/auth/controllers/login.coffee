AuthLoginController = ($state, AuthService) ->
  vm = this
  vm.credentials = {}
  vm.submit = (form) ->
    return if form.$invalid
    AuthService.authenticate(vm.credentials)
      .then (response) ->
        $state.go('wr.users.list')
  return

AuthLoginController.$inject = ['$state', 'AuthService']

angular.module 'wr.auth'
  .controller 'AuthLoginController', AuthLoginController
