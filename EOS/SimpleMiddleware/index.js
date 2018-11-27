
// Require Modules

const { BaseActionWatcher } = require("demux");
const { NodeosActionReader } = require("demux-eos");
const ObjectActionHandler = require("./ObjectActionHandler");
const handler = require("./handlerVersions/v1");

// let Eos = require('eosjs');

// Setting Variables

const actionHandler = new ObjectActionHandler(handler.updaters, handler.effects);

// let eos = Eos({
//     chainId: '5fff1dae8dc8e2fc4d5b23b2c7665c97f9e9d8edf2b6485a86ba311c25639191',
//     keyProvider: [
//         "5Kdcpisr8cmUG1g4NieMw1g2z7VY2E6jCyZ8329QBAESW9aUxHX", // 1111test1115 active_key
//         "5KGmxEH1btmzUceKP9ED6Z16DsWPxg794JxSsmyjJTYXV2APrcb" // 1111test1115 owner_key
//     ],
//     httpEndpoint: "http://api.kylin.helloeos.com.cn",
//     broadcast: true,
//     verbose: true,
//     sign: true
// });



const actionReader = new NodeosActionReader(
    "http://api.kylin.helloeos.com.cn",
    0
);

const actionWatcher = new BaseActionWatcher(
    actionReader,
    actionHandler,
    250
);



actionWatcher.watch();
