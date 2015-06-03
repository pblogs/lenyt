var gulp = require('gulp')
var webpack = require('gulp-webpack')
var rename = require('gulp-rename')

gulp.task('webpack', function () {
  return gulp.src('javascripts/lenyt.js')
    .pipe(webpack({}))
    .pipe(rename('lenyt-app.js'))
    .pipe(gulp.dest('../app/assets/javascripts'))
})

gulp.task('watch', function () {
  gulp.watch('javascripts/**/*', ['webpack'])
})
