
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



function effect(state, payload, blockInfo, context) {
    console.log("\n - " + payload.account + "::" + payload.name + "() - " + new Date().toISOString());
    console.log(": payload");
    console.log(payload);
    console.log(": blockInfo");
    console.log(blockInfo);
}

const effects = [
    {
        actionType: "simplectr::cbsetdata",
        effect: effect
    }, {
        actionType: "simplectrc::setdatacore",
        effect: effect
    }
];



const handlerVersion = {
    versionName: "v1",
    updaters,
    effects,
};

module.exports = handlerVersion;
