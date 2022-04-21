const Web3 = require('web3');
const web3 = new Web3('http://127.0.0.1:7545');
const contractAddress = '0xA66eF8fa1f01bFE1eA2Fff442cb9E95f4b2b243c';
const SimpleBankABI = require('../build/contracts/SimpleBank.json');

( async () => {
        try {
            let accounts = await web3.eth.getAccounts();
            console.log('address',accounts);
            var SimpleBank = new web3.eth.Contract(SimpleBankABI.abi, contractAddress);
        
            const txOptions = {
                from: accounts[1]
            }
        
            tx = await SimpleBank.methods.register();
            txnResp = await tx.send(txOptions);
            console.log(JSON.stringify(txnResp.txHash))
        } catch(err) {
            throw Error(err)
        }
    }
)();