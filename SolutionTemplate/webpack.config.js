const webpack = require('webpack');
const CopyWebpackPlugin = require('copy-webpack-plugin');
const { CleanWebpackPlugin } = require('clean-webpack-plugin');
const glob = require("glob");
const _ = require('lodash');

module.exports = {
    // Add entry point for each entity to be compiled.
    entry: Object.assign({},
        _.reduce(glob.sync("./WebResources/src/ts/**/*.ts"),
            (obj, val) => {
                const filenameRegex = /([\w\d_-]*)\.?[^\\\/]*$/i;
                obj[val.match(filenameRegex)[1]] = val;
                return obj;
            },
            {})
    ),
    output: {
        filename: "[name].js",
        path: __dirname + "/dist",
        library: 'AddName_[name]'
    },
    mode: 'production',
    resolve: {
        // Add '.ts' and '.tsx' as resolvable extensions.
        extensions: [".ts", ".tsx", ".js", ".json"]
    },

    devtool: 'inline-source-map',

    module: {
        rules: [
            // All files with a '.ts' or '.tsx' extension will be handled by 'awesome-typescript-loader'.
            { test: /\.tsx?$/, loader: "awesome-typescript-loader" },
            { test: /\.js$/, use: ["source-map-loader"], enforce: "pre" }
        ]
    },
    plugins: [
        new CleanWebpackPlugin(),
        new CopyWebpackPlugin([
            { from: 'WebResources/src/css', to: 'css' },
            { from: 'WebResources/src/html', to: 'html' },
            { from: 'WebResources/src/images', to: 'images' },
            { from: 'WebResources/src/library', to: 'library' }
        ])
    ]
};