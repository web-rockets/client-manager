describe 'API Service', () ->
  beforeEach module 'wr.api'

  describe 'get(url, params):', () ->
    it 'should call $http.get', inject ($http, API) ->
      # Arrange
      spyOn($http, 'get')
      # Act
      API.get '/dummy'
      # Assert
      expect($http.get).toHaveBeenCalledWith('/api/dummy', undefined)

  describe 'post(url, params):', () ->
    it 'should call $http.post', inject (API, $http) ->
      # Arrange
      spyOn($http, 'post')
      # Act
      API.post('/dummy')
      # Assert
      expect($http.post).toHaveBeenCalledWith('/api/dummy', undefined)

  describe 'put(url, params):', () ->
    it 'should call $http.put', inject (API, $http) ->
      # Arrange
      spyOn($http, 'put')
      # Act
      API.put('/dummy')
      # Assert
      expect($http.put).toHaveBeenCalledWith('/api/dummy', undefined)

  describe 'delete(url, params):', () ->
    it 'should call $http.delete', inject (API, $http) ->
      # Arrange
      spyOn($http, 'delete')
      # Act
      API.delete('/dummy')
      # Assert
      expect($http.delete).toHaveBeenCalledWith('/api/dummy', undefined)
