
let Eos = require('eosjs');

let eos = Eos({
    chainId: '5fff1dae8dc8e2fc4d5b23b2c7665c97f9e9d8edf2b6485a86ba311c25639191',
    keyProvider: [
        "5Kdcpisr8cmUG1g4NieMw1g2z7VY2E6jCyZ8329QBAESW9aUxHX", // 1111test1115 active_key
        "5KGmxEH1btmzUceKP9ED6Z16DsWPxg794JxSsmyjJTYXV2APrcb", // 1111test1115 owner_key
        "5KETTzk9pcr8aTDmNUsMq9LSHqZxJN5wpzvVQ6MaU9gX48g5oqV", // 1111testcore active_key
        "5KcfBowZcVTR1Hd1GDGQsNuQ2hT7aHexH6TQnEso31VEcubXPHY" // 1111testcore owner_key
    ],
    httpEndpoint: "http://api.kylin.helloeos.com.cn",
    broadcast: true,
    verbose: true,
    sign: true
});

console.log("\n Send - " + process.argv[3] + "(\"" + process.argv[4] + "\"); -p " + process.argv[2] + "@" + process.argv[5] + "\n");

eos.transaction({
    actions: [{
        account: process.argv[2],
        name: process.argv[3],
        data: {
            from: process.argv[2],
            to: process.argv[2],
            data: process.argv[4]
        },
        authorization: [{
            actor: process.argv[2],
            permission: process.argv[5]
        }]
    }]
});

console.log("\n Sended - " + process.argv[3] + "(\"" + process.argv[4] + "\"); -p " + process.argv[2] + "@" + process.argv[5] + "\n");
