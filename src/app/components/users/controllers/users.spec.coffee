describe 'UsersController', ->
  beforeEach module 'wr.users'

  scope = undefined
  users = []

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    $controller('UsersController as vm', $scope: scope, users: users)

  it 'should received a resolved array of users', ->
    expect(scope.vm.users).toEqual(users)
  it 'should have a displayedUsers variable for smart-table', ->
    expect(scope.vm.displayedUsers).toBeDefined()

  describe 'when edit(user)', ->
    it 'should change to wr.users.edit state', inject ($state) ->
      # Arrange
      spyOn($state, 'go')
      user = id: 1, name: 'Marco'
      # Act
      scope.vm.edit(user)
      # Assert
      expect($state.go).toHaveBeenCalledWith('wr.users.edit', id: user.id)

  describe 'when newUser()', ->
    it 'should change to wr.users.new state', inject ($state) ->
      # Arrange
      spyOn($state, 'go')
      # Act
      scope.vm.newUser()
      # Assert
      expect($state.go).toHaveBeenCalledWith 'wr.users.new'

  describe 'when delete(user)', ->
    user = id: 1, name: 'Marco'

    it 'should call userService.delete(user)', inject (userService, $q) ->
      # Arrange
      deferredDelete = $q.defer()
      spyOn(userService, 'delete').and.returnValue(deferredDelete.promise)
      deferredDelete.resolve data: user
      # Act
      scope.vm.delete user
      # Assert
      expect(userService.delete).toHaveBeenCalledWith user

    it 'should remove the user from array', inject (userService, $q) ->
      # Arrange
      deferredDelete = $q.defer()
      users.push user
      spyOn(userService, 'delete').and.returnValue(deferredDelete.promise)
      deferredDelete.resolve data: user
      # Act
      scope.vm.delete user
      scope.$digest()
      # Assert
      expect(userService.delete).toHaveBeenCalledWith user
      expect(scope.vm.users).not.toContain(user)
      expect(scope.vm.users.length).toBe(0)
