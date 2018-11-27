import { Block } from "./interfaces";
/**
 * Reads blocks from a blockchain, outputting normalized `Block` objects.
 */
export declare abstract class AbstractActionReader {
    startAtBlock: number;
    protected onlyIrreversible: boolean;
    protected maxHistoryLength: number;
    headBlockNumber: number;
    currentBlockNumber: number;
    isFirstBlock: boolean;
    protected currentBlockData: Block | null;
    protected blockHistory: Block[];
    constructor(startAtBlock?: number, onlyIrreversible?: boolean, maxHistoryLength?: number);
    /**
     * Loads the head block number, returning an int.
     * If onlyIrreversible is true, return the most recent irreversible block number
     * @return {Promise<number>}
     */
    abstract getHeadBlockNumber(): Promise<number>;
    /**
     * Loads a block with the given block number
     * @param {number} blockNumber - Number of the block to retrieve
     * @returns {Block}
     */
    abstract getBlock(blockNumber: number): Promise<Block>;
    /**
     * Loads the next block with chainInterface after validating, updating all relevant state.
     * If block fails validation, resolveFork will be called, and will update state to last block unseen.
     */
    nextBlock(): Promise<[Block, boolean, boolean]>;
    /**
     * Move to the specified block.
     */
    seekToBlock(blockNumber: number): Promise<void>;
    /**
     * Incrementally rolls back reader state one block at a time, comparing the blockHistory with
     * newly fetched blocks. Fork resolution is finished when either the current block's previous hash
     * matches the previous block's hash, or when history is exhausted.
     *
     * @return {Promise<void>}
     */
    protected resolveFork(): Promise<void>;
    /**
     * When history is exhausted in resolveFork(), this is run to handle the situation. If left unimplemented,
     * then only instantiate with `onlyIrreversible` set to true.
     */
    protected historyExhausted(): void;
}
