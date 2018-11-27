
function parseTokenString(tokenString) {
    const [amountString, symbol] = tokenString.split(" ");
    const amount = parseFloat(amountString);
    return { amount, symbol };
}

function updateTransferData(state, payload, blockInfo, context) {
    const { amount, symbol } = parseTokenString(payload.data.quantity);
    if (!state.volumeBySymbol[symbol]) {
        state.volumeBySymbol[symbol] = amount;
    } else {
        state.volumeBySymbol[symbol] += amount;
    }
    state.totalTransfers += 1;
    context.stateCopy = JSON.parse(JSON.stringify(state));
}

const updaters = [{
    actionType: "eosio.token::transfer",
    updater: updateTransferData
}];



function logUpdate(state, payload, blockInfo, context) {console.log(payload);console.log(blockInfo);console.log(context);
    console.info("State updated:\n", JSON.stringify(context.stateCopy, null, 2));
}

function greet(state, payload, blockInfo, context) {
    console.log(blockInfo.data);
}

function hello(state, payload, blockInfo, context) {
    console.log("\n\n - hello() - " + new Date().toISOString());
    // console.log("\n : state");
    // console.log(state);
    console.log("\n : payload");
    console.log(payload);
    console.log("\n : blockInfo");
    console.log(blockInfo);
    // console.log("\n : context");
    // console.log(context);
}

function ontested(state, payload, blockInfo, context) {
    console.log("\n\n - ontested() - " + new Date().toISOString());
    // console.log("\n : state");
    // console.log(state);
    console.log("\n : payload");
    console.log(payload);
    console.log("\n : blockInfo");
    console.log(blockInfo);
    // console.log("\n : context");
    // console.log(context);
}

const effects = [
    {
        actionType: "eosio.token::transfer1",
        effect: logUpdate
    }, {
        actionType: "11111hangole::greet",
        effect: greet
    }, {
        actionType: "1111test1115::hello",
        effect: hello
    }, {
        actionType: "1111testcore::ontested",
        effect: ontested
    }
];



const handlerVersion = {
    versionName: "v1",
    updaters,
    effects,
};

module.exports = handlerVersion;
