describe 'userService', ->
  beforeEach module 'wr.users'
  describe 'when all()', ->
    it 'should return all users in a promise', inject (userService, $rootScope, $q, API) ->
      # Arrange
      getPromise = $q.defer()
      spyOn(API, 'get').and.returnValue getPromise.promise
      expectedUsers = ['user1', 'user2']
      getPromise.resolve data: expectedUsers
      # Act
      userService.all().then (users) ->
        expect(users).toEqual(expectedUsers)
      $rootScope.$digest()
      # Assert
      expect(API.get).toHaveBeenCalledWith('/users')

  describe 'when delete(user)', ->
    it 'should call API.delete method and return the removed user', inject (userService, API, $q, $rootScope, notify) ->
      # Arrange
      deferredDelete = $q.defer()
      spyOn(notify, 'success').and.callThrough()
      spyOn(API, 'delete').and.returnValue deferredDelete.promise
      removedUser = id: 3, name: 'Marco Túlio'
      user = angular.copy removedUser
      deferredDelete.resolve(data: removedUser)
      # Act
      userService.delete(user).then (user) ->
        expect(user).toBe(removedUser)
      $rootScope.$digest()
      # Assert
      expect(API.delete).toHaveBeenCalledWith('/users/3')
      expect(notify.success).toHaveBeenCalledWith(message: 'users.action.successfully_deleted')

  describe 'when get(id)', ->
    it 'should expect a user object from a request', inject (API, userService, $q, $rootScope) ->
      # Arrange
      deferredGet = $q.defer()
      spyOn(API, 'get').and.returnValue(deferredGet.promise)
      spyOn(userService, 'get').and.callThrough()
      expectedUser =
        id:1
        name: 'Marco'
      deferredGet.resolve(data: expectedUser)
      # Act
      userService.get(1).then (user) ->
        # Assert
        expect(user).toEqual(expectedUser)
      $rootScope.$digest()
      expect(userService.get).toHaveBeenCalledWith(1)
      expect(API.get).toHaveBeenCalledWith('/users/1')

  describe 'when newUser()', ->
    it 'should return an empty object', inject (userService) ->
      # Assert
      expect(userService.newUser()).toEqual({})

  describe 'when save(user)', ->
    deferredRequest = undefined
    exampleUser =
      id: 2
      name: 'Marco'

    beforeEach inject (API, $q, notify) ->
      deferredRequest = $q.defer()
      spyOn(API, 'put').and.returnValue(deferredRequest.promise)
      spyOn(API, 'post').and.returnValue(deferredRequest.promise)
      spyOn(notify, 'success').and.callThrough()
      spyOn(notify, 'error').and.callThrough()
      deferredRequest.resolve data: exampleUser

    it 'should call API.put if user has id', inject (userService, $rootScope, API, notify) ->
      # Act
      userService.save(exampleUser).then (user) ->
        # Assert
        expect(user).toEqual(exampleUser)
      $rootScope.$digest()
      expect(API.put).toHaveBeenCalledWith('/users/2', user: exampleUser)
      expect(API.post).not.toHaveBeenCalled()
      expect(notify.success).toHaveBeenCalledWith(message: 'users.action.successfully_updated')
    it 'should call API.post if user does not have and id', inject (userService, $rootScope, API, notify) ->
      # Arrange
      delete exampleUser.id
      # Act
      userService.save(exampleUser).then (user) ->
        # Assert
        expect(user).toEqual(exampleUser)
      $rootScope.$digest()
      expect(API.post).toHaveBeenCalledWith('/users', user: exampleUser)
      expect(API.put).not.toHaveBeenCalled()
      expect(notify.success).toHaveBeenCalledWith(message: 'users.action.successfully_saved')

