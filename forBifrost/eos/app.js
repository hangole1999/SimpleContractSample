
let Eos = require('eosjs');

let eos = Eos({
    chainId: '5fff1dae8dc8e2fc4d5b23b2c7665c97f9e9d8edf2b6485a86ba311c25639191',
    keyProvider: [
        "5JAvP7utEDeCzqtv9dC1PMAPNeq7MYDQKUcSzCv24udwfMdDp8e",
        "5KRrvpjGc3jnM6nfGPjDmC282wYaPFvuzpGGWugEU8UZuqSEaDb",
        "5KPW4Sa3cdVgL3vwojQcA6LLbwJCT8huk6nfZ48K3gPBoZG3qwg",
        "5Kkk6BWATXDVfDuxFn7bYE3EqjAiSmm283YdAbRBG1ecTunjSty",
        "5JKcNVWHCARSVfacrArZUxfVhLKPpFGtBYFFu8eVNLusnvyqHwK",
        "5J7LeDJG3FmHtQFfzvTMWsfHtBD3TxwiG9ZD6RC4aVx5zxtXapc"
    ],
    httpEndpoint: "http://api.kylin.helloeos.com.cn",
    // expireInSeconds: 10,
    broadcast: true,
    verbose: true,
    sign: true
});

// eos.transaction({
//     actions: [{
//         account: "11111hangole",
//         name: "greet",
//         data: {
//             from: "11111hangole",
//             to: "11111hangole",
//             user: "11111hangole"
//         },
//         authorization: [{
//             actor: "11111hangole",
//             permission: "active"
//         }]
//     }]
// });

eos.transaction({
    actions: [{
        account: "1111test1114",
        name: "hi",
        data: {
            from: "1111test1114",
            to: "1111test1114",
            data: "1"
        },
        authorization: [{
            actor: "1111test1114",
            permission: "active"
        }]
    }]
});

// eos.transfer('11111hangole', '11111111test', '1.0000 EOS', 'test send', 
//     (error, result) => {
//         if(error) {
//             console.error('\n !!! Failed...');
//             console.error(error);
//         } else {
//             console.log("\n !!! Success!");
//             console.log(result);
//         }
//     }
// );
