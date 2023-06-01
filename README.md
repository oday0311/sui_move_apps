

编译
sui move build


部署

sui client publish --gas-budget 20000000 ./


调用

sui client call --function getCounter --module counter --package 0x2dd7799b671703f2470fdac80e712cb6de8807da69be0afb9d2c3aa9860a7e91 --gas-budget 100000000


Incr
sui client call --function incr --module counter --package 0x2dd7799b671703f2470fdac80e712cb6de8807da69be0afb9d2c3aa9860a7e91 --args 0x732038fb064e8eae4d1590f142ed6308d0fe643076f52949cf88bd2135a9747f --gas-budget 100000000







Lots of Move code examples, partitioned by category:

* basics: The very simplest examples of Sui programming.
* crypto: A simple contract to perform ECDSA secp256k1 signature verification and ecrecover (derive the public key from a signature).
* defi: DeFi primitives like escrows, atomic swaps, flash loans, DEXes.
* fungible_tokens: Implementations of fungible tokens with different minting and burning policies.
* games: Various classic and not-so-classic on-chain games.
* nfts: Example NFT implementations and related functionality like auctions and marketplaces.

We welcome third-party examples--please just submit a pull request!

DISCLAIMER: This is example code provided for demonstration purposes only. These examples have not been thoroughly tested, verified, or audited. Please do not use the example code or derivatives in production without proper diligence.
