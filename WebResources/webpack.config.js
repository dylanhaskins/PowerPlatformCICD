const webpack = require('webpack');
const CopyWebpackPlugin = require('copy-webpack-plugin');
const { CleanWebpackPlugin } = require('clean-webpack-plugin');

module.exports = {
    // Add entry point for each entity to be compiled.
    entry: {
        systemuser: './Webresources/src/ts/forms/systemuser.ts',
    },
    output: {
        filename: "[name].js",
        path: __dirname + "/dist",
        library: '[name]'
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
        ])
    ]
};