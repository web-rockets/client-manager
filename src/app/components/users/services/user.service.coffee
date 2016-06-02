class UserService
  # Inject all dependencies
  constructor: (API) ->
    @api = API

  # Returns all users
  all: -> return @api.get('/users').then (response) -> return response.data

  # Deletes a user
  delete: (user) -> return @api.delete('/users/' + user.id).then (response) -> return response.data

  # Returns a user by id
  get: (id) -> return @api.get('/users/' + id).then (response) -> return response.data

  # Returns a new user which is a empty object
  newUser: -> return {}

  # Saves a user
  save: (user) ->
    if user.id
      return @api.put('/users/' + user.id, {user: user}).then (response) -> return response.data
    else
      return @api.post('/users', {user: user}).then (response) -> return response.data

UserService.$inject = ['API']

angular.module('wr.users').service('userService', UserService)
