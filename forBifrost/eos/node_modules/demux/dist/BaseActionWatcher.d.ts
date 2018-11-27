import { AbstractActionHandler } from "./AbstractActionHandler";
import { AbstractActionReader } from "./AbstractActionReader";
/**
 * Coordinates implementations of `AbstractActionReader`s and `AbstractActionHandler`s in
 * a polling loop.
 */
export declare class BaseActionWatcher {
    protected actionReader: AbstractActionReader;
    protected actionHandler: AbstractActionHandler;
    protected pollInterval: number;
    constructor(actionReader: AbstractActionReader, actionHandler: AbstractActionHandler, pollInterval: number);
    /**
     * Starts a polling loop running in replay mode.
     */
    replay(): Promise<void>;
    /**
     * Start a polling loop
     */
    watch(isReplay?: boolean): Promise<void>;
    /**
     * Use the actionReader and actionHandler to process new blocks.
     */
    protected checkForBlocks(isReplay?: boolean): Promise<void>;
}
