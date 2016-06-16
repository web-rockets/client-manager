angular.module 'wr.auth.login-dropdown', []
  .directive 'wrLoginDropdown', ->

    LoginDropdownController = ($localStorage) ->
      'ngInject'
      vm = this
      vm.current_user = $localStorage.current_user
      return

    directive =
      restrict: 'E'
      templateUrl: 'app/components/login-dropdown/login-dropdown.html'
      replace: true
      controller: LoginDropdownController
      controllerAs: 'vm'
      bindToController: true
