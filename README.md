# Confirm NFT

Confirm tokens for a given contract on the calling wallet

- Foundry
- Docker

1. `forge create --contracts contracts/confirmnft.sol --rpc-url ${DEVNET_RPC} --private-key ${DEVNET_WALLET} --etherscan-api-key ${ETHERSCAN_API_KEY} --verify ConfirmNFT`

```
Compiler run successful
Deployer: 0x6CEb0bF1f28ca4165d5C0A04f61DC733987eD6ad
Deployed to: 0xEED08072c41235bC9DE0846D9D49F096Cc15A750
Transaction hash: 0x580d7cef16b77901f67eb8875400996bd9d6e45e530fc8f5180ec19029aadf33
Starting contract verification...
Waiting for etherscan to detect contract deployment...

Submitting verification for [contracts/confirmnft.sol:ConfirmNFT] Ok("0xEED08072c41235bC9DE0846D9D49F096Cc15A750").
Submitted contract for verification:
        Response: `OK`
        GUID: `73inbuc8ate6lbzixbyqitzbzksegp9dgya5aud6mntprjjpy5`
        URL:
        https://goerli.etherscan.io/address/0xeed08072c41235bc9de0846d9d49f096cc15a750
Waiting for verification result...
Contract successfully verified
```


## Example

```
cast call 0xEED08072c41235bC9DE0846D9D49F096Cc15A750 "emitConfirmedTokens(address)" --rpc-url ${DEV_RPC_URL} --from ${DEV_ETH_PUBLIC} 0xE3C82840FA0605a424Cc1ea6BC013D12909E4e69
```
