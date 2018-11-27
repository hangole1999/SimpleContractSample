"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
class NodeosBlock {
    constructor(rawBlock) {
        this.actions = this.collectActionsFromBlock(rawBlock);
        this.blockInfo = {
            blockNumber: rawBlock.block_num,
            blockHash: rawBlock.id,
            previousBlockHash: rawBlock.previous,
            timestamp: new Date(rawBlock.timestamp),
        };
    }
    collectActionsFromBlock(rawBlock) {
        return this.flattenArray(rawBlock.transactions.map((transaction) => {
            if (!transaction.trx.transaction) {
                return []; // Deferred transaction, cannot decode
            }
            return transaction.trx.transaction.actions.map((action, actionIndex) => {
                // Delete unneeded hex data if we have deserialized data
                if (action.data) {
                    delete action.hex_data; // eslint-disable-line
                }
                return {
                    type: `${action.account}::${action.name}`,
                    payload: Object.assign({ transactionId: transaction.trx.id, actionIndex }, action),
                };
            });
        }));
    }
    flattenArray(arr) {
        return arr.reduce((flat, toFlatten) => flat.concat(Array.isArray(toFlatten) ? this.flattenArray(toFlatten) : toFlatten), []);
    }
}
exports.NodeosBlock = NodeosBlock;
