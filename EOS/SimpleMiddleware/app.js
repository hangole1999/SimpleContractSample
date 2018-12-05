
let Eos = require('eosjs');

let eos = Eos({
    chainId: 'cf057bbfb72640471fd910bcb67639c22df9f92470936cddc1ade0e2f2e7dc4f',
    keyProvider: [
        "5JaN8UKeQqpBPMLwZXp127sLh5LHRWkYaKMFvmmFJmQGUUAwpcn", // test / simplectr / simplectrc active_key (private net)
        "5JKyzggcSmByHZ1fojZYHVvLh7ksDEgJ2S1MdsL39qm2HcGoF1k" // test / simplectr / simplectrc owner_key (private net)
    ],
    httpEndpoint: "http://localhost:8888",
    broadcast: true,
    verbose: true,
    logger: {
        log: function(e) {
            console.log("\n - : - LOGING");
            console.log(e);
        },
        error: function(e) {
            console.log("\n - : - ERROR LOGING");
            console.log(e);
        }
    },
    sign: true
});



function sendTransaction(data) {
    eos.transaction({
        actions: [{
            account: data.from,
            name: data.name,
            data: data,
            authorization: [{
                actor: data.from,
                permission: "active"
            }]
        }]
    }).then(e => {
        try {
            var result = JSON.parse(e.processed.action_traces[0].console);
    
            if (result) {
                sendTransaction(result);
            }
        } catch(e) {
        }
    });
}

// $ node app.js simplectr setdata 12345

sendTransaction({
    from: process.argv[2],
    to: process.argv[2],
    name: process.argv[3],
    data: process.argv[4]
});
