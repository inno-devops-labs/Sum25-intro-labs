# Lab 10: Decentralized Web Hosting with IPFS & 4EVERLAND

## Task 1: Local IPFS Node Setup and File Publishing

** Start IPFS container **
docker run -d --name ipfs_node \
  -v ipfs_staging:/export \
  -v ipfs_data:/data/ipfs \
  -p 4001:4001 -p 8080:8080 -p 5001:5001 \
  ipfs/kubo:latest

**Verify node operation**
└─# docker exec ipfs_node ipfs swarm peers
/ip4/107.172.158.254/udp/4001/quic-v1/p2p/12D3KooWHimfir21wjhgumPWZyYtm9661g1miq1TydE6dDt2xegG
/ip4/108.61.197.17/tcp/4001/p2p/12D3KooWHpyTEUyxta45xs8PLsD1vcbXKYRVEU1WrtmQbx4Zmjyk
/ip4/114.246.201.39/tcp/13114/p2p/QmQsz9fJsrtC66hDJmJtsttu7gndiMeg5tT2s7Bmv19ayj
/ip4/115.204.155.52/tcp/29662/p2p/QmUxa895qJg3jkzxB7MFc8WREasmnWqgxxV68wCZqsmbex
/ip4/138.197.123.17/udp/4001/quic-v1/p2p/12D3KooWPg8bc8D9fqAd5gFoZFb61JgpLa7xAKyrWkaxtyTPgQ95
/ip4/139.178.91.71/udp/4001/quic-v1/p2p/QmNnooDu7bfjPFoTZYxMNLWUQJyrVwtbZg5gBMjTezGAJN
/ip4/141.164.61.153/tcp/4001/p2p/12D3KooWR1ybfzkcoB3BDiUaGF4BDtpuPd7MwU9WMVMFMgjBAL2Z
/ip4/141.95.162.3/udp/4001/quic-v1/p2p/12D3KooWCzcHxcx5oGtNM3nPUqW47yuoWfbLs2ZLtJaMtMX3zodN
/ip4/144.91.126.246/udp/4001/quic-v1/p2p/12D3KooWPpd3cjpWLJ3fJ9GcNa1GS63cfiU2o4Sm5KcKEyomEAg4
/ip4/145.40.118.135/udp/4001/quic-v1/p2p/QmcZf59bWwK5XFi76CZX8cbJ4BhTzzA3gU1ZjYZcYW3dwt
/ip4/147.75.87.27/udp/4001/quic-v1/p2p/QmbLHAnMoJPWSCR5Zhtx6BHJX9KiKNN6tpvbUcqanj75Nb
/ip4/149.28.212.203/tcp/4001/p2p/12D3KooWRhFaBejrJHQeGpYaDxVhkzZNHWaTc3QQSydhMZTFSo5B
/ip4/150.109.229.227/tcp/43647/p2p/QmaN8LbthCa5PryXcV15Bm24T44bKyp5mJZCkaBF4JADPH
/ip4/152.53.140.194/tcp/29073/p2p/QmdCLh6wDfHc411sswCSMTua6ZfK1tHD7Pp69xy6B3f2gW
/ip4/152.53.185.91/tcp/25979/p2p/QmS1k5esE244UPhTw8F9VKPX3qbq3TpNs5uAychhmF294n
/ip4/154.12.226.213/tcp/4001/p2p/12D3KooWG8ijPGM5hcxUrDsQgcG6TqDH54gJArdwjfhWhMvLEBsJ
/ip4/158.247.202.79/tcp/4001/p2p/12D3KooWEeCtSVCr8cy9M8mfYqMV9TKgVzk13EBgXsJhTxDE6DzM
/ip4/162.19.251.237/udp/4001/quic-v1/p2p/12D3KooWJ8bqXU83MTrS4NY7dQvxrZjxX9NyQ3beRHgkSstyWZgk
/ip4/167.235.135.35/udp/4001/quic-v1/p2p/12D3KooWBcUnwJ9gzzrdGgNdLQ6R8uMvpDqeikPTSiziJL74VAFu

**Create file**
└─# echo "Hello IPFS-Lab" > test.txt 

└─# docker exec ipfs_node ipfs add /export/test.txt
 15 B / ? added Qmf5xaR5Kqrp3ZFfrqo7aLqKUAri8BsYpjKMEVEvfsLPCc test.txt
 15 B / 15 B  100.00%   

└─# docker cp test.txt ipfs_node:/export/      
Successfully copied 2.05kB to ipfs_node:/export/

**Access content**
Via local gateway: screen ipfs-hello-local.png
Via public gateway: screen ipfs-hello-gate.png
web GUI: web.png

  ### Results

  - IPFS Node Peer Count: 83
  - IPFS Node Bandwidth: 975 KiB/s incoming and 34 KiB/s outcoming
  - Test File CID: - Qmf5xaR5Kqrp3ZFfrqo7aLqKUAri8BsYpjKMEVEvfsLPCc
  - Public Gateway URL: https://ipfs.io/ipfs/Qmf5xaR5Kqrp3ZFfrqo7aLqKUAri8BsYpjKMEVEvfsLPCc

## Task 2: Static Site Deployment with 4EVERLAND

**Deployment dashboard:**
screen project.png

**My site**
screen my-site

  ### Results

  - 4EVERLAND Project URL https://sum25-intro-labs-s9fwo5x8-m0cbka.4everland.app/
  - GitHub Repository https://github.com/m0CbKa/Sum25-intro-labs/
