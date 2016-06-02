usersConfig = ($stateProvider) ->
  # Get users for UsersController
  getUsers = (userService) ->
    userService.all().then (users) -> return users
  getUsers.$inject = ['userService']

  # Gets user by id for UserFormController
  getUser = (userService, $stateParams) ->
    userService.get($stateParams.id).then (user) -> return user
  getUser.$inject = ['userService', '$stateParams']

  # Creates a new user
  newUser = (userService) -> return userService.newUser()
  newUser.$inject = ['userService']

  $stateProvider
    .state 'wr.users',
      abstract: true
      url: '/users'
      views:
        'content':
          template: '<div ui-view="content" class="wr-entrance"></div>'
    .state 'wr.users.list',
      url: ''
      views:
        'content':
          templateUrl: 'app/components/users/views/list.html'
          controller: 'UsersController as vm'
          resolve:
            users: getUsers
    .state 'wr.users.edit',
      url: '/:id/edit'
      views:
        'content':
          templateUrl: 'app/components/users/views/edit.html'
          controller: 'UserFormController as vm'
          resolve:
            user: getUser
    .state 'wr.users.new',
      url: '/new'
      views:
        'content':
          templateUrl: 'app/components/users/views/new.html'
          controller: 'UserFormController as vm'
          resolve:
            user: newUser

usersConfig.$inject = ['$stateProvider']
angular.module('wr.users')
  .config usersConfig
