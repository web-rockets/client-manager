usersConfig = ($stateProvider) ->
  $stateProvider
    .state 'wr.users',
      url: '/users'
      views:
        'content':
          templateUrl: 'app/components/users/views/list.html'

usersConfig.$inject = ['$stateProvider']
angular.module('wr.users')
  .config usersConfig
