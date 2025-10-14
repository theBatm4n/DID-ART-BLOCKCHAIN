# ArtDID Registry

A decentralized identity system for art credentials using DLT Besu blockchain.

## Quick Start

### Prerequisites
- Node.js 18+
- Docker
- Git

### Setup & Run
```bash
# 1. Clone and install
git clone <your-repo>
cd art-did-demo
npm install

# 2. Start Besu blockchain
docker run -d -p 8545:8545 --name besu-demo \
  hyperledger/besu:latest \
  --network=dev --miner-enabled \
  --miner-coinbase=0xfe3b557e8fb62b89f4916b721be55ceb828dbd73 \
  --rpc-http-enabled --rpc-http-host=0.0.0.0 \
  --host-allowlist="*" --rpc-http-cors-origins="*"

# 3. Verify Besu is running
curl -X POST http://localhost:8545 \
  -H "Content-Type: application/json" \
  --data '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}'

# 4. Compile and deploy contract
npx hardhat compile
npx hardhat run scripts/deploy.js --network besu

# 5. Run tests (make sure to change the contract address with the result from the previous command)
npx hardhat run scripts/test.js --network besu
