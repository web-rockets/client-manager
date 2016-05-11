###
@todo Complete the test
This example is not perfect.
Test should check if MomentJS have been called
###
describe 'directive navbar', () ->
  vm = undefined
  element = undefined
  timeInMs = undefined

  beforeEach module 'clientManager'

  beforeEach inject ($compile, $rootScope) ->
    timeInMs = new Date()
    timeInMs = timeInMs.setHours timeInMs.getHours() - 24

    element = angular.element "<wr-navbar></wr-navbar>"

    $compile(element) $rootScope.$new()
    $rootScope.$digest()
    vm = element.isolateScope().vm

  it 'should be compiled', () ->
    expect(element.html()).not.toEqual null
