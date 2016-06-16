Routes = ($stateProvider) ->
  $stateProvider
    .state 'wr.auth',
      url: '/auth'
      abstract: true
    .state 'wr.auth.login',
      url: '^/login'
      views:
        'index@':
          templateUrl: 'app/components/auth/views/login.html'
          controller: 'AuthLoginController as vm'
    .state 'wr.auth.logout',
      url: '^/logout'
      views:
        'index@':
          templateUrl: 'app/components/auth/views/login.html'
          controller: 'AuthLogoutController'
    .state 'wr.auth.404',
      url: '^/404'
      views:
        'index@':
          templateUrl: 'app/components/auth/views/404.html'

Routes.$inject = ['$stateProvider']

angular.module 'wr.auth'
  .config Routes

