# Decentralized Web Hosting with IPFS & 4EVERLAND

## Task 1: Local IPFS Node Setup and File Publishing

1. **Start IPFS container**:

   ```bash
   docker run -d --name ipfs_node \
     -v ipfs_staging:/export \
     -v ipfs_data:/data/ipfs \
     -p 4001:4001 -p 8080:8080 -p 5001:5001 \
     ipfs/kubo:latest
   ```

2. **Verify node operation**:

   ```bash
   docker exec ipfs_node ipfs swarm peers
   ```
вывод:
```
root@ubuntu:/home/user# docker exec ipfs_node ipfs swarm peers
/ip4/101.47.180.121/tcp/43127/p2p/QmYFJ2pEtFiCLyswhw6vc6HSwgpMynPQsneqCEFZ82vqwC
/ip4/101.47.181.227/tcp/36311/p2p/QmUjCQ6aj4gj7xZEKiPWTXbkyzn2ttYKpo5EbLX4X5jLgz
/ip4/101.47.182.6/tcp/45789/p2p/QmXWEwvrkV3B4wxsXbCQ1q5Vn4c6K7y6G6sqJiMNZ5DdT7
/ip4/103.253.147.245/tcp/4001/p2p/12D3KooWL56t2x25773n7BDqEPaUuQ8ZbUa2wMVSx9JLQdFn9Y2Y
/ip4/107.172.142.61/tcp/4001/p2p/12D3KooWEQ7ij5t4r3iSWNTQcBV69rsLEH6CmZVU3s61bjeBCLKQ
/ip4/108.174.61.152/tcp/4001/p2p/12D3KooWKHcdkTyiWpiVPC6GT8d5t2ZVBEmYwpvx63LutgyRpLnM
/ip4/109.123.255.196/tcp/39565/p2p/QmWU5qTjHngbHLUg39Z7bjhpPHuUNejAmiKoxEdzP3KNwD
/ip4/116.163.20.242/tcp/14001/p2p/12D3KooWMVuxudH6mt7PsJc4C9XgPggZwpFz3Q6J1gfUSQ4rxdHk
/ip4/116.232.158.135/tcp/62199/p2p/12D3KooWAxY1WTye72yF14X5VwnzkEXmDgXk5MsUds9sY1HLyboo
/ip4/119.54.54.242/udp/34242/quic-v1/p2p/12D3KooWRBiH5Nmm8TbGzkqeRSGXZn2uar9fpV7RiyPBH8hooiVo
/ip4/139.178.91.71/udp/4001/quic-v1/p2p/QmNnooDu7bfjPFoTZYxMNLWUQJyrVwtbZg5gBMjTezGAJN
/ip4/139.60.161.31/udp/4001/quic-v1/p2p/12D3KooWGTyNBNnoKLJ2fXunkKVUaEeAwcdK4LyvbfzvLHV46BA1
/ip4/139.84.200.254/tcp/4001/p2p/12D3KooWAWnQ4XWyhnMUvUafr964cQS7FTAwWZ9mVL2CQEb7XDbL
/ip4/141.98.17.157/udp/4001/quic-v1/p2p/12D3KooWQRJ9cy7wrJSmXHwF5DuBAmxJq54cDf3c2dkwD7QSHUtv
/ip4/144.217.79.33/tcp/4001/p2p/12D3KooWGFbcCPH5AgjrdTMwGPkTC3oftqqkbXCEQNgiaUBDHcBg
/ip4/144.91.81.178/udp/4001/quic-v1/p2p/12D3KooWQBJfFKBQQrYq2Hy5BeKP5DSfa2d33CkztGThe2rjpqh1
/ip4/145.223.82.247/udp/4001/quic-v1/p2p/12D3KooWPShge7KW6mCGoN9W6hyFyqSFhF5xAWaaBqmQD5zpAmNy
/ip4/145.40.118.135/udp/4001/quic-v1/p2p/QmcZf59bWwK5XFi76CZX8cbJ4BhTzzA3gU1ZjYZcYW3dwt
/ip4/146.0.72.166/udp/4001/quic-v1/p2p/12D3KooWHgQvCzj9tznS9XmAtiGTRMLV2L7hVvRk9TDW3ZsCRbiR
/ip4/147.75.87.27/udp/4001/quic-v1/p2p/QmbLHAnMoJPWSCR5Zhtx6BHJX9KiKNN6tpvbUcqanj75Nb
/ip4/152.53.117.114/tcp/36973/p2p/QmeyFjDpjbsLb857TRpcMqNB3NPKp9S8v2NUfMVbEQ8L3N
/ip4/155.138.204.240/tcp/4001/p2p/12D3KooWNMC7fNVG4K8jGY9BCRdFhvZWw5kupved1Aeeatf4H1n7
/ip4/155.138.236.131/tcp/4001/p2p/12D3KooWKR1GEL6HKGZHG7Zi3C6qpUt2wdFJ2wU1KwUidKrySzbd
/ip4/157.20.104.248/udp/4001/quic-v1/p2p/12D3KooWHKKMtk4ksNRsKtAMdYaRxMGALj6W86kCEgmpWypvrv5M
/ip4/157.90.91.35/tcp/46179/p2p/Qmd2CPS64cGsp4T5zrTjea6dogEhT1PmMGTxPvh3MRH74N
/ip4/158.69.26.101/tcp/4001/p2p/12D3KooWHEZmjeA1exvbRj68D632JpYb7ALDR5sPqYs5NhRZnQvZ
/ip4/162.55.134.135/tcp/45401/p2p/12D3KooWFJVPkXjudVRQmdeA5SJDbCsxKs8KcB2GDzrfb5YK6q1z
/ip4/162.55.243.101/tcp/15401/p2p/12D3KooWRkhFPSGQcrTCxwbMiibEt4AxidqcPv3HSoA5vw5zWqiU
...
```

3. **Add file to IPFS**:

   ```bash
   echo "Hello IPFS Lab" > testfile.txt
   docker cp testfile.txt ipfs_node:/export/
   docker exec ipfs_node ipfs add /export/testfile.txt
   ```
Вывод:
```
root@ubuntu:/home/user# echo "Hello IPFS Lab" > testfile.txt
root@ubuntu:/home/user# docker cp testfile.txt ipfs_node:/export/
Successfully copied 2.05kB to ipfs_node:/export/
root@ubuntu:/home/user# docker exec ipfs_node ipfs add /export/testfile.txt
 15 B / ? added QmUFJmQRosK4Amzcjwbip8kV3gkJ8jqCURjCNxuv3bWYS1 testfile.txt
```

4. **Access content**:  

local gateway:
![ipfs](/img/26.png)

public gateways:
![ipfs](/img/27.png)

IPFS web UI:
![ipfs](/img/28.png)


## Task 2: Static Site Deployment with 4EVERLAND


1. **Set up 4EVERLAND project**:  
![ipfs](/img/29.png)

2. **Verify deployment**:

*.4everland.app subdomain
![ipfs](/img/31.png)
  
public gateway
![ipfs](/img/30.png)



   ## Task 1 Results
   - IPFS Node Peer Count: 64
   - IPFS Node Bandwidth: входящий 2Kb/s,исходящий 148B/s
   - Test File CID: QmUFJmQRosK4Amzcjwbip8kV3gkJ8jqCURjCNxuv3bWYS1
   - Public Gateway URL: https://ipfs.io/ipfs/QmUFJmQRosK4Amzcjwbip8kV3gkJ8jqCURjCNxuv3bWYS1

   ## Task 2 Results
   - 4EVERLAND Project URL: https://sum25-intro-labs-7-dr0h.4everland.app/
   - IPFS CID from 4EVERLAND: bafybeihzarmfcsys5au2yx3mhemrowy2x4xg4pckz3s7rxbipa3etpsjzm
