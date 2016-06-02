UserFormController = (userService, user, $state) ->
  vm = this
  vm.user = user
  vm.submitted = false
  vm.submit = (form) ->
    vm.submitted = true
    if form.$invalid
      return
    userService.save(vm.user).then (user) ->
      $state.go 'wr.users.list'
      # TODO: toaster success
      return user
  return

UserFormController.$inject = ['userService', 'user', '$state']
angular.module 'wr.users'
  .controller 'UserFormController', UserFormController
