# Confirm NFT

Confirm tokens for a given contract on the calling wallet

- Foundry
- Docker

1. `forge create --contracts contracts/confirmnft.sol --rpc-url ${DEVNET_RPC} --private-key ${DEVNET_WALLET} --etherscan-api-key ${ETHERSCAN_API_KEY} --verify ConfirmNFT`

## 0.0.1

```
Compiling 21 files with 0.8.16
Solc 0.8.16 finished in 2.61s
Compiler run successful
Deployer: 0x6CEb0bF1f28ca4165d5C0A04f61DC733987eD6ad
Deployed to: 0x7838314CCDe9C6251645c1FC32A63Ed2D481601D
Transaction hash: 0x6412e7f5cd21e680cfc24a2bf06e936ccdd50474cda01f70863606db52616bcd
Starting contract verification...
Waiting for etherscan to detect contract deployment...

Submitting verification for [contracts/confirmnft.sol:ConfirmNFT] "0x7838314CCDe9C6251645c1FC32A63Ed2D481601D".

Submitting verification for [contracts/confirmnft.sol:ConfirmNFT] "0x7838314CCDe9C6251645c1FC32A63Ed2D481601D".

Submitting verification for [contracts/confirmnft.sol:ConfirmNFT] "0x7838314CCDe9C6251645c1FC32A63Ed2D481601D".

Submitting verification for [contracts/confirmnft.sol:ConfirmNFT] "0x7838314CCDe9C6251645c1FC32A63Ed2D481601D".

Submitting verification for [contracts/confirmnft.sol:ConfirmNFT] "0x7838314CCDe9C6251645c1FC32A63Ed2D481601D".

Submitting verification for [contracts/confirmnft.sol:ConfirmNFT] "0x7838314CCDe9C6251645c1FC32A63Ed2D481601D".

Submitting verification for [contracts/confirmnft.sol:ConfirmNFT] "0x7838314CCDe9C6251645c1FC32A63Ed2D481601D".

Submitting verification for [contracts/confirmnft.sol:ConfirmNFT] "0x7838314CCDe9C6251645c1FC32A63Ed2D481601D".
Submitted contract for verification:
	Response: `OK`
	GUID: `pmbwm77xrtydi7h5rpdyksffl4jjksaacngmfxau2zfnp7aacb`
	URL:
        https://goerli.etherscan.io/address/0x7838314ccde9c6251645c1fc32a63ed2d481601d
Waiting for verification result...
Contract successfully verified
```


## Example

```
cast call 0x7838314CCDe9C6251645c1FC32A63Ed2D481601D "emitConfirmedTokens(address)" --rpc-url ${DEV_RPC_URL} --from ${DEV_ETH_PUBLIC} 0xE3C82840FA0605a424Cc1ea6BC013D12909E4e69
```
