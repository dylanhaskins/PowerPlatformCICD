module.exports = function (api) {
    api.cache(true);

    const presets = [
        "@babel/typescript",
        [
            "@babel/env", {
                "modules": false
            }
        ]
    ];
    const plugins = [];

    return {
        presets,
        plugins
    };
}