import { Block, BlockInfo } from "demux";
import { EosAction } from "./interfaces";
export declare class NodeosBlock implements Block {
    actions: EosAction[];
    blockInfo: BlockInfo;
    constructor(rawBlock: any);
    protected collectActionsFromBlock(rawBlock: any): EosAction[];
    private flattenArray;
}
