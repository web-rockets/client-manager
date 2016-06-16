angular.module 'clientManager'
  .config ($logProvider, $translateProvider, APIConfig) ->
    'ngInject'
    $translateProvider.useSanitizeValueStrategy null

    # Enable log
    $logProvider.debugEnabled true
    $translateProvider.preferredLanguage('br')

    angular.extend APIConfig, {
      baseUrl: 'http://localhost:4000'
    }
