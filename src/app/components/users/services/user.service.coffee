class UserService
  $inject: ['API', 'notify']
  # Inject all dependencies
  constructor: (API, notify) ->
    @api = API
    @notify = notify

  # Returns all users
  all: -> return @api.get('/users').then (response) -> return response.data

  # Deletes a user
  delete: (user) ->
    $this = @
    return @api.delete('/users/' + user.id).then (response) ->
      $this.notify.success message: 'users.action.successfully_deleted'
      return response.data

  # Returns a user by id
  get: (id) -> return @api.get('/users/' + id).then (response) -> return response.data

  # Returns a new user which is a empty object
  newUser: -> return {}

  # Saves a user
  save: (user) ->
    $this = @
    if user.id
      return @api.put('/users/' + user.id, {user: user}).then (response) ->
        $this.notify.success message: 'users.action.successfully_updated'
        return response.data
    else
      return @api.post('/users', {user: user}).then (response) ->
        $this.notify.success message: 'users.action.successfully_saved'
        return response.data

angular.module('wr.users').service('userService', UserService)
