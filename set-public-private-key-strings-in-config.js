const parsedJSON = require('/root/ganache-accounts.json');
console.info("parsedJSON", parsedJSON);
const playBookFilePath = "/root/playbook/playbook.yml";
const fs = require('fs');
fs.readFile(playBookFilePath, 'utf8', function (err, data) {
    if (err) {
        return console.error(err);
    }
    let index = 1;
    for (const addr in parsedJSON.private_keys) {
        const privateKey = parsedJSON.private_keys[addr];
        let r = new RegExp("wallet" + index + "Key", "g");
        data = data.replace(r, privateKey);

        r = new RegExp("wallet" + index + "Addr", "g");
        data = data.replace(r, addr);
        index++;
    }

    fs.writeFile(playBookFilePath, data, 'utf8', function (err) {
        if (err) return console.error(err);
    });
});