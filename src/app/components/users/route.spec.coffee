describe 'Users Routes', ->
  userServiceMock = {}
  beforeEach ->
    module 'ui.router', ($stateProvider) ->
      $stateProvider
        .state 'wr',
          abstract: true
          url: ''
          views:
            'index':
              template: '<div id="content" class="container wr-entrance" ui-view="content"></div>'
      return
    module 'wr.users', ($provide, $injector) ->
      $provide.value 'userService', userServiceMock
      return

  it 'should resolve users with userService.all() method in /users route',
    inject ($state, $injector, $q, $rootScope) ->
      # Arrange
      exampleUsers = ['user1', 'user2']
      deferredAll = $q.defer()
      userServiceMock.all = jasmine.createSpy('all').and.returnValue(deferredAll.promise)
      usersListState = $state.get('wr.users.list')
      deferredAll.resolve(exampleUsers)
      # Act
      users = $injector.invoke(usersListState.views.content.resolve.users)
      $rootScope.$digest()
      # Assert
      expect(users.$$state.value).toEqual exampleUsers

  it 'should resolve user with userService.get(id) method in /users/:id/edit route',
    inject ($state, $injector, $q, $rootScope) ->
      # Arrange
      editedUser = id: 4, name: 'Marco Túlio'
      deferredGet = $q.defer()
      userServiceMock.get = jasmine.createSpy('get').and.returnValue(deferredGet.promise)
      usersEditState = $state.get('wr.users.edit')
      deferredGet.resolve(editedUser)
      # Act
      user = $injector.invoke(usersEditState.views.content.resolve.user)
      $rootScope.$digest()
      # Assert
      expect(user.$$state.value).toEqual editedUser

  it 'should resolve new user with userService.newUser() method in /users/new route',
    inject ($state, $injector) ->
      # Arrange
      newUser = {}
      userServiceMock.newUser = jasmine.createSpy('newUser').and.returnValue(newUser)
      usersNewState = $state.get('wr.users.new')
      # Act
      user = $injector.invoke(usersNewState.views.content.resolve.user)
      # Assert
      expect(user).toBe newUser

