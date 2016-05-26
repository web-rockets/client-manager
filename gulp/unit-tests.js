'use strict';

var path = require('path');
var gulp = require('gulp');
var conf = require('./conf');

var karma = require('karma');

var pathSrcHtml = [
  path.join(conf.paths.src, '/**/*.html')
];

var pathSrcJs = [
  path.join(conf.paths.tmp, '/**/!(*.spec).js')
];

function runTests (singleRun, done) {
  var reporters = ['progress'];
  var preprocessors = {};
  var coverageReporter = {
    dir: 'coverage',
    reporters: [
      { type: 'html', subdir: 'report-html' },
      { type: 'lcov', subdir: 'report-lcov' },
      { type: 'text-summary' },
    ]
  }

  pathSrcHtml.forEach(function(path) {
    preprocessors[path] = ['ng-html2js'];
  });

  pathSrcJs.forEach(function(path) {
    preprocessors[path] = ['coverage'];
  });
  reporters.push('coverage')
  if (singleRun) {
    coverageReporter.reporters.pop()
    coverageReporter.reporters.push({type: 'text'})
  }

  var localConfig = {
    configFile: path.join(__dirname, '/../karma.conf.js'),
    singleRun: singleRun,
    autoWatch: !singleRun,
    reporters: reporters,
    preprocessors: preprocessors,
    coverageReporter: coverageReporter
  };

  var server = new karma.Server(localConfig, function(failCount) {
    done(failCount ? new Error("Failed " + failCount + " tests.") : null);
  })
  server.start();
}

gulp.task('test', ['scripts'], function(done) {
  runTests(true, done);
});

gulp.task('test:auto', ['watch'], function(done) {
  runTests(false, done);
});
