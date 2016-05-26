describe 'controllers', () ->
  vm = undefined

  beforeEach module 'clientManager'

  beforeEach inject ($controller, toastr) ->
    vm = $controller 'MainController'

  it 'should define more than 5 awesome things', () ->
