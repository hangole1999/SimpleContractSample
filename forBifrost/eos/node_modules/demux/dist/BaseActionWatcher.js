"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : new P(function (resolve) { resolve(result.value); }).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
/**
 * Coordinates implementations of `AbstractActionReader`s and `AbstractActionHandler`s in
 * a polling loop.
 */
class BaseActionWatcher {
    constructor(actionReader, actionHandler, pollInterval) {
        this.actionReader = actionReader;
        this.actionHandler = actionHandler;
        this.pollInterval = pollInterval;
    }
    /**
     * Starts a polling loop running in replay mode.
     */
    replay() {
        return __awaiter(this, void 0, void 0, function* () {
            yield this.watch(true);
        });
    }
    /**
     * Start a polling loop
     */
    watch(isReplay = false) {
        return __awaiter(this, void 0, void 0, function* () {
            const startTime = new Date().getTime();
            yield this.checkForBlocks(isReplay);
            const endTime = new Date().getTime();
            const duration = endTime - startTime;
            let waitTime = this.pollInterval - duration;
            if (waitTime < 0) {
                waitTime = 0;
            }
            setTimeout(() => __awaiter(this, void 0, void 0, function* () { return yield this.watch(false); }), waitTime);
        });
    }
    /**
     * Use the actionReader and actionHandler to process new blocks.
     */
    checkForBlocks(isReplay = false) {
        return __awaiter(this, void 0, void 0, function* () {
            let headBlockNumber = 0;
            while (!headBlockNumber || this.actionReader.currentBlockNumber < headBlockNumber) {
                const [blockData, isRollback, isNewBlock] = yield this.actionReader.nextBlock();
                if (!isNewBlock) {
                    break;
                }
                let needToSeek = false;
                let seekBlockNum = 0;
                if (blockData) {
                    [needToSeek, seekBlockNum] = yield this.actionHandler.handleBlock(blockData, isRollback, this.actionReader.isFirstBlock, isReplay);
                }
                if (needToSeek) {
                    yield this.actionReader.seekToBlock(seekBlockNum - 1);
                }
                headBlockNumber = this.actionReader.headBlockNumber;
            }
        });
    }
}
exports.BaseActionWatcher = BaseActionWatcher;
