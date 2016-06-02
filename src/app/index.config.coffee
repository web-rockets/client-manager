angular.module 'clientManager'
  .config ($logProvider, toastrConfig, $translateProvider, APIConfig) ->
    'ngInject'
    # Enable log
    $logProvider.debugEnabled true
    # Set options third-party lib
    toastrConfig.allowHtml = true
    toastrConfig.timeOut = 3000
    toastrConfig.positionClass = 'toast-top-right'
    toastrConfig.preventDuplicates = true
    toastrConfig.progressBar = true
    $translateProvider.preferredLanguage('br')

    angular.extend APIConfig, {
      baseUrl: 'http://localhost:4000'
    }
