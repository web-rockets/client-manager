angular.module 'wr.notify'
  .config (toastrConfig) ->
    'ngInject'
    # Set options third-party lib
    toastrConfig.allowHtml = true
    toastrConfig.timeOut = 5000
    toastrConfig.positionClass = 'toast-top-right'
    toastrConfig.preventDuplicates = false
    toastrConfig.progressBar = true