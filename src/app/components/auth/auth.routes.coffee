Routes = ($stateProvider) ->
  $stateProvider
    .state 'wr.auth',
      url: '/auth'
      views:
        'index@':
          templateUrl: 'app/components/auth/views/login.html'
          controller: 'LoginController as vm'

Routes.$inject = ['$stateProvider']

angular.module 'wr.auth'
  .config Routes

