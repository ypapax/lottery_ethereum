var Lottery = artifacts.require("./Lottery.sol");
// and then you can call it in develop console by:
// HelloWorld.deployed().then(h => h.greet());
module.exports = function (deployer, network) {
    console.info("network", network);
    deployer.deploy(Lottery);
};