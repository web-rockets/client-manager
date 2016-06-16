angular.module 'clientManager'
  .config ($stateProvider, $urlRouterProvider) ->
    'ngInject'

    $stateProvider
      .state 'wr',
        url: ''
        abstract: true
        views:
          'index':
            templateUrl: 'app/main/main.html'
      .state 'wr.home',
        url: '/home'
        views:
          'content':
            templateUrl: 'app/main/main.html'
            controller: 'MainController'
            controllerAs: 'main'

    $urlRouterProvider.when '', '/users'
    $urlRouterProvider.when '/', '/users'
    $urlRouterProvider.otherwise '/404'
