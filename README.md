# arc-dao-treasury

Lightweight DAO treasury with multi-sig USDC spending proposals

## Built for Arc Blockchain

- **Chain ID:** 5042002
- **RPC:** https://rpc.testnet.arc.network
- **Explorer:** https://testnet.arcscan.app
- **Gas Token:** USDC (6 decimals)

## Smart Contract: DaoTreasury

### Features
- `propose()`
- `vote()`
- `execute()`
- `deposit()`
- `deposit()` — Deposit USDC into the contract
- `withdrawAll()` — Owner withdraws all USDC

## Development

```bash
cd contracts
forge install
forge build
forge test -vv
```

## Deploy to Arc Testnet

```bash
cd contracts
forge create src/DaoTreasury.sol:DaoTreasury \
  --rpc-url https://rpc.testnet.arc.network \
  --private-key $PRIVATE_KEY \
  --constructor-args 0x3600000000000000000000000000000000000000 \
  --legacy
```

## License

MIT
