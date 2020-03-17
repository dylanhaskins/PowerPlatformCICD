const gulp = require('gulp');
const useTsConfig = require('gulp-use-tsconfig');
const minify = require('gulp-minify');

const tsConfig = './tsconfig.json';

var del = require('del');


gulp.task('clean', function clean() {
    return del(['./dist']);
});

gulp.task('pre-build', function () {
    return gulp.src(tsConfig)
        .pipe(useTsConfig.clean()); // Remove all .js; .map and .d.ts files
});

gulp.task('build', gulp.series(['pre-build', 'clean'], function () {
    return gulp.src(tsConfig)
        .pipe(useTsConfig.build())
        .pipe(minify({
            ext: {
                // src:'.js',
                min: '.js'
            },
            noSource: true,
        }))
        .pipe(gulp.dest('./dist/js/'));// generates .js and optionaly .map and/or .d.ts files
}));

gulp.task('watch', gulp.series(['build'], function () {
    return gulp.src(tsConfig)
        .pipe(useTsConfig.watch());
}));

function copyimages() {
    return gulp.src(['./WebResources/src/images/**'])
        .pipe(gulp.dest('./dist/images'));
};

function copycss() {
    return gulp.src(['./WebResources/src/css/**'])
        .pipe(gulp.dest('./dist/css'));
};

function copyhtml() {
    return gulp.src(['./WebResources/src/html/**'])
        .pipe(gulp.dest('./dist/html'));
};

function copylibrary() {
    return gulp.src(['./WebResources/src/library/**'])
        .pipe(gulp.dest('./dist/library'));
};

gulp.task('copy-files', gulp.parallel(copyimages, copycss, copyhtml, copylibrary));

gulp.task('default', gulp.series(['build', 'copy-files']));
