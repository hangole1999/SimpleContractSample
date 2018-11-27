export declare const nodeosRawBlock: {
    timestamp: string;
    producer: string;
    confirmed: number;
    previous: string;
    transaction_mroot: string;
    action_mroot: string;
    schedule_version: number;
    new_producers: null;
    header_extensions: never[];
    producer_signature: string;
    transactions: {
        status: string;
        cpu_usage_us: number;
        net_usage_words: number;
        trx: {
            id: string;
            signatures: string[];
            compression: string;
            packed_context_free_data: string;
            context_free_data: never[];
            packed_trx: string;
            transaction: {
                expiration: string;
                ref_block_num: number;
                ref_block_prefix: number;
                max_net_usage_words: number;
                max_cpu_usage_ms: number;
                delay_sec: number;
                context_free_actions: never[];
                actions: {
                    account: string;
                    name: string;
                    authorization: {
                        actor: string;
                        permission: string;
                    }[];
                    data: {
                        memo: string;
                    };
                    hex_data: string;
                }[];
                transaction_extensions: never[];
            };
        };
    }[];
    block_extensions: never[];
    id: string;
    block_num: number;
    ref_block_prefix: number;
};
