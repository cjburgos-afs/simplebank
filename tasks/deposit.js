const Web3 = require('web3');
const web3 = new Web3('http://127.0.0.1:7545');
const contractAddress = '0xA66eF8fa1f01bFE1eA2Fff442cb9E95f4b2b243c';
const SimpleBankABI = require('../build/contracts/SimpleBank.json');
const depositAmount = 5;
const CONV = 10 ** 18;
( async () => {
        try {
            let accounts = await web3.eth.getAccounts();
            console.log('address',accounts);
            var SimpleBank = new web3.eth.Contract(SimpleBankABI.abi, contractAddress,{from: accounts[1]});
        
            const txOptions = {
                from: accounts[1],
                value: depositAmount * CONV
            }
        
            tx = await SimpleBank.methods.deposit();
            txHash = await tx.send(txOptions);
            console.log(txHash)
        } catch(err) {
            throw Error(err)
        }
    }
)();