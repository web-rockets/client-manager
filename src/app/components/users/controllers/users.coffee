UsersController = (users, $state, userService) ->
  vm = this
  vm.users = users
  vm.displayedUsers = [].concat(vm.users)

  vm.edit = (user) -> $state.go('wr.users.edit', id: user.id)
  vm.newUser = -> $state.go('wr.users.new')
  vm.delete = (user) ->
    userService.delete(user).then (removed) ->
      # TODO: toastr.success('users.successfully.deleted')
      vm.users.splice vm.users.indexOf(user), 1
  return

UsersController.$inject = ['users', '$state', 'userService']
angular.module 'wr.users'
  .controller 'UsersController', UsersController
