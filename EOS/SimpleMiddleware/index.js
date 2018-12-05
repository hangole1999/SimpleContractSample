
const { BaseActionWatcher } = require("demux");
const { NodeosActionReader } = require("demux-eos");
const ObjectActionHandler = require("./ObjectActionHandler");
const handler = require("./handlerVersions/v1");

const actionHandler = new ObjectActionHandler(handler.updaters, handler.effects);



const actionReader = new NodeosActionReader(
    "http://localhost:8888",
    0
);

const actionWatcher = new BaseActionWatcher(
    actionReader,
    actionHandler,
    250
);



actionWatcher.watch();
