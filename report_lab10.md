# Decentralized Web Hosting with IPFS & 4EVERLAND

In this lab, you'll explore decentralized web technologies by setting up a local IPFS node, publishing content to the distributed web, and deploying a static site using 4EVERLAND's automation platform.

---

## Task 1: Local IPFS Node Setup and File Publishing

**Objective**: Run a personal IPFS node using Docker, publish files to the IPFS network, and verify decentralized access through public gateways.

IPFS (InterPlanetary File System) enables decentralized, content-addressed storage that's resilient to single-point failures. Understanding IPFS helps prepare for Web3 development and decentralized application hosting.

1. **Start IPFS container**:

   ```bash
   docker run -d --name ipfs_node \
     -v ipfs_staging:/export \
     -v ipfs_data:/data/ipfs \
     -p 4001:4001 -p 8080:8080 -p 5001:5001 \
     ipfs/kubo:latest
   ```

<img width="1088" height="507" alt="image" src="https://github.com/user-attachments/assets/8527b29d-c2a3-4774-aa71-7904c1c0d0fc" />

   - Wait 60 seconds for initialization

2. **Verify node operation**:

   ```bash
   docker exec ipfs_node ipfs swarm peers
   ```

   - Should show connected peers

```
vboxuser@xubu:~$ sudo docker exec ipfs_node ipfs swarm peers
/ip4/101.33.81.69/tcp/39131/p2p/QmXisskEpAPqS2iUh9mXBxjGiH1pk7WpjKMibLMQWvpmCN
/ip4/101.47.182.75/tcp/38781/p2p/QmfTeyzvVF5sVgbKJtASJzSS1EfA7LrncP6dc3CgGc6HY8
/ip4/104.207.147.137/udp/4001/quic-v1/p2p/12D3KooWGJrpC4DCBjQmVD6sN3NgRhf32LT98k2Qchdte7XDQmWR
/ip4/104.250.129.19/tcp/44453/p2p/Qmf5MBkbnQbxRFWu3VQ72A2eQYupcNn9KEbmtJu9Rpcdrq
/ip4/107.150.45.250/udp/4001/quic-v1/p2p/12D3KooWM8tGA3TN5YZ5EYFKXvmJrEZcVpGUaRw4nyh8whsDNwYV
/ip4/107.173.40.108/tcp/4001/p2p/12D3KooWHyNCG7AQXX68DgWxDJb4thdLbtj3KL8dPrWjj7iMVL9S
/ip4/111.59.141.195/udp/59248/quic-v1/p2p/12D3KooWDChtDdn7zn3x9NtYmZf1xgRKu1enDrfr6rM8113hysnr
/ip4/125.86.15.20/udp/35010/quic-v1/p2p/12D3KooWCBahVzmbarVimhMKihMJ4q5r2ueNNR7YXQqCug5pLUSA
/ip4/136.243.70.180/tcp/45167/p2p/QmU6ZJ9Te6ynrQLEthSTHiTK6foSLpb9yYvwuveVbd2rUx
/ip4/137.220.62.158/tcp/4001/p2p/12D3KooWLkDyPY19fRTfyTbXa1N9hR5YVWn4TYPUjHG7xcNT9Vyw
/ip4/139.60.162.70/udp/4001/quic-v1/p2p/12D3KooWRgS3xHtaNfzGHGMAo4mcxsV2y5qMmkhqjXH5vxbG1Qhq
/ip4/141.164.55.56/udp/4001/quic-v1/p2p/12D3KooWDf2GriVEBZGP2YKBWmmoFJ6ombsZijtcDTHZ3e7YsMXE
/ip4/145.40.118.135/udp/4001/quic-v1/p2p/QmcZf59bWwK5XFi76CZX8cbJ4BhTzzA3gU1ZjYZcYW3dwt
/ip4/146.0.75.143/udp/4001/quic-v1/p2p/12D3KooWMHQE731kke1sgHAAkRRiU6Uq8DLqzfvGwPjS9GFpcZer
/ip4/149.28.106.184/tcp/4001/p2p/12D3KooWAxbNSVFzDQEHiteuzjpp7UyV86Y6sVZNxN3fpRmVT4UA
/ip4/152.53.16.28/tcp/20823/p2p/QmWAkRY1aJkcpMn9iRR62gn1XYgeaAr57NRgy7cBuViCvX
/ip4/152.53.164.27/tcp/22817/p2p/QmcQmPcQvUEhHZjdZF74ok9WwS8ogfqMo3mpxxfZjo6ySu
/ip4/154.219.114.181/tcp/44735/p2p/QmRAnx5p9kkgupQbJRXhXNRLS87TrAnxiydj2fUriABECd
/ip4/155.138.162.120/udp/4001/quic-v1/p2p/12D3KooWHMaTCWs2pJUctePasenDhApfGoADAkyLhYp664GYt19F
/ip4/157.90.181.211/tcp/4001/p2p/12D3KooWGaxbu3g9Zhp3B78JtYXPXrUZPwhkLmeaKexrJk4KDFMD
/ip4/16.162.124.222/tcp/4001/p2p/12D3KooWHEFmHVXbWJSnSmaNkYWBXgNcGnasZyCRCyZJSVKoJK1G
/ip4/161.97.154.132/tcp/39247/p2p/QmTWyJUsTCqVPxgNoQwfxAmVYeLw3vaHEHhjxz5RjkPSqV
/ip4/161.97.68.117/tcp/4001/p2p/12D3KooWCMFwNFHCfC81reM9MXCyHVioKtFkna6rKYsV9bzCpviX
/ip4/162.55.66.116/tcp/37341/p2p/QmQ9KmYgJmz6Tyg6cqfBxbSgYs8jD4TBLCBmViXfYQ1YGo
/ip4/165.232.136.77/tcp/45763/p2p/QmTHpu3w47eZdoH8gZZ5gd5iUp4egEn8XwRmSqfacyPkQc
/ip4/167.235.97.185/tcp/33711/p2p/QmZuXY5RtLmSuaxyMwTSqprDMNXjAtDSk5aXzdLYiXDeCJ
/ip4/168.119.210.182/tcp/46483/p2p/QmTPwzrc2kYerPWfEKLMtqdLpcXQyShwuTcwUr3TMw6YPZ
/ip4/168.119.70.158/tcp/37449/p2p/QmPdtC3jgXVJNPJGNTk4S4mcihTipFjPteiswKeDTo7MYF
/ip4/183.230.248.90/tcp/43533/p2p/QmaW7tTSWrs6ngQzRC3EbXoYCLBrLYzkNxdAvKUdp3PQ66
/ip4/185.211.5.189/tcp/40413/p2p/QmNWg2SM6A9DFPtsr6he3mQA2vNsfh17jSKhBKDST5WCSc
/ip4/192.227.212.29/tcp/4001/p2p/12D3KooWQaPPUpwSsjANgmTFiUmzS6VAVSjo4nrUHJNLCWJKFUTd
/ip4/192.99.152.126/tcp/4001/p2p/12D3KooWPMZUXsdBphHySNsapbeDEaSwWh4fug94qFAGquA1DL9J
/ip4/194.247.183.20/tcp/39459/p2p/QmcpM8AuCDpa65R4bQNe2p89QREqsA7oRrH7udBvUEcfsR
/ip4/194.75.20.20/tcp/4001/p2p/12D3KooWESBi5yqxUaXfANg3bpt5WiRMwHRnrzHnffKoJ4SyWeA8
/ip4/195.26.249.235/tcp/42615/p2p/QmaPYxyMWaGbRrp5umGqyXSUGKT2oBkVY79swy3VwwVBym
/ip4/206.72.206.178/udp/4001/quic-v1/p2p/12D3KooWDvG6M4n2BanUgx72NaSnJxifFsUso6umFcWsamWWTtWM
/ip4/216.128.137.158/tcp/4001/p2p/12D3KooWMpgBPDqS2MXkFqEidHP8yUG5xUVtGjR7FsTZHhQGh3WS
/ip4/216.245.184.173/udp/4001/quic-v1/p2p/12D3KooWCYLnS5URNdhxbyjRtYfXEpFgnpnuvmKosZSwt3d1Li2i
/ip4/23.95.246.161/tcp/4001/p2p/12D3KooWC829qyprbmJTRDtd9BboK7TeaV5GVDajZkEKahDZsckX
/ip4/35.185.132.165/tcp/4001/p2p/QmPXEuepbvaKiFQQQfzqMZTdpQkiDp2tEJ2UdALmkKjfux
/ip4/38.58.181.148/udp/4001/quic-v1/p2p/12D3KooWPUHTQi9Fwv2fd538L8FUkXbX8VHud4YBtPShLHgNLx5r
/ip4/40.160.7.178/tcp/4001/p2p/12D3KooWFij8YUzLPHuPaX5FP5g5LbR3dZxP17hFKGfQe8E5nwif
/ip4/43.128.252.142/tcp/37261/p2p/QmWH7KWo7F5GkPjoB43UudMd5eYfNfnnY6L3tA2sabQgDE
/ip4/43.153.178.5/tcp/37917/p2p/QmUXNoX5Kpei1x1zAuGKX7mWAX67PaFAqJEiPTfwKTP3ep
/ip4/43.155.153.36/tcp/41273/p2p/QmRnGdDhWusHaic5RnB7hCjTfoWzpQjNumYnKhrgH6BAjh
/ip4/43.155.169.190/tcp/38851/p2p/QmVVpKPpkLgUgbBahhtWYj5DTzNtfz3ZS6nXRPPVFq5qTw
/ip4/43.155.179.101/tcp/34713/p2p/QmZibM6vZYypE7bWSCbGca2gictvuca3FR5PVtT8CiHbLi
/ip4/43.167.169.46/tcp/43437/p2p/QmUXZU2ZKt1YgpxG4FapC9Bzqvo5HxdnLWKWzJZAFagfZJ
/ip4/5.181.50.239/tcp/28383/p2p/QmdY4vkDV9kdPuFtVMm75Uo43efcCX7yjybiaWJ4kybAkg
/ip4/51.159.103.9/tcp/4001/p2p/12D3KooWNMsv8YWV7knic3dCxDYuDPcH6ESSL7kt2J3PVBPjeQKi
/ip4/54.227.217.212/tcp/4001/p2p/12D3KooWDB1wTcDec6jyws3tXmXibT1h6q7ktAN3sKzsQ98PFRzP
/ip4/59.58.104.125/tcp/52511/p2p/QmW4H5aPPjtt5za5NuzjLjt6Bjaq2yTqJfd9QXMUMTRTuD
/ip4/59.58.104.27/tcp/51820/p2p/QmYe9Gi7BYZK2o9sjihKkA9hVyKuHr6Mb5ZLLkLqFxVnep
/ip4/62.171.171.66/tcp/37121/p2p/QmYNpJTcPYbE2DiTXEZtJf6oXT5iqaU6HG5KUeP64VnoXv
/ip4/67.219.109.175/udp/4001/quic-v1/p2p/12D3KooWH4uEbWaemQXssLLa3vRxUBGwMCPWeW5NKccZVTEVtvnx
/ip4/86.48.17.234/udp/4001/quic-v1/p2p/12D3KooWD7S9ULjX6xv9bTox6huA6G7845GGYpVj4EA7VwoHP5Bi
/ip4/87.120.165.233/tcp/41077/p2p/QmPGybCCBTbLcY5prX8dNDtAf5434CyNds4eDvzpFX4QhY
/ip4/87.120.186.145/tcp/36549/p2p/QmZCY428VfQ2fFKAfUpKFsxXNvprZFautHhRgz2CTZWBph
/ip4/87.120.186.34/tcp/33895/p2p/Qmf641hecR5GAdKf7ipM7EzB59h96SvqV94PfjX8cExmA4
/ip4/87.121.105.156/tcp/39789/p2p/Qmba26zLQJWJLqeUWCtntae7EnCSrqJWE2vxZhxL7zB7V9
/ip4/87.121.89.4/tcp/40935/p2p/QmZvBNtqzGyDE8EdoxprhPfPzf4Am51Qbgjy6tGBXTtQNW
/ip4/88.99.97.98/tcp/4001/p2p/12D3KooWHoDmhEmam4rizDWvBrmtETC44gUVLwdDXeqBFCXRRnJb
/ip4/94.141.161.175/tcp/34267/p2p/QmYKtZWK2PugAAGw6mTuEbK8nStRC8PH8NPVxJPiZA7aWG
/ip4/94.156.114.251/tcp/42043/p2p/QmeBmPxcEFNgbuVLZYxFRBQUXqTWivVc7W3bB7sys7focX
vboxuser@xubu:~$ 

```

3. **Add file to IPFS**:

   ```bash
   echo "Hello IPFS Lab" > testfile.txt
   docker cp testfile.txt ipfs_node:/export/
   docker exec ipfs_node ipfs add /export/testfile.txt
   ```

   - Note the generated CID (e.g., QmXgZAUWd8yo4tvjBETqzUy3wLx5YRzuDwUQnBwRGrAmAo)

<img width="725" height="135" alt="image" src="https://github.com/user-attachments/assets/b04479f7-4011-426f-b883-c586446d51ac" />

4. **Access content**:
   - Via local gateway: `http://localhost:8080/ipfs/<CID>`
   - Via public gateways:
     - `https://ipfs.io/ipfs/<CID>`
     - `https://cloudflare-ipfs.com/ipfs/<CID>`
   - *Note: Public access may take 2-5 minutes*
   - Open a browser and access the IPFS web UI:

     ```sh
     http://127.0.0.1:5001/webui/
     ```

   - Share information about connected peers and bandwidth in your report.
   - Provide the hash (CID) and the public gateway URLs used to verify the file on the IPFS gateways.

<img width="679" height="127" alt="image" src="https://github.com/user-attachments/assets/92a5d044-c736-451e-bd77-f0011ab31c3e" />

use ``` QmUFJmQRosK4Amzcjwbip8kV3gkJ8jqCURjCNxuv3bWYS1 ``` in ``` http://localhost:8080/ipfs/QmUFJmQRosK4Amzcjwbip8kV3gkJ8jqCURjCNxuv3bWYS1 ```

<img width="1009" height="206" alt="image" src="https://github.com/user-attachments/assets/a8ab8281-aa39-499d-834b-f762681c42c4" />

<img width="1665" height="1336" alt="image" src="https://github.com/user-attachments/assets/eae29fb1-68ab-43ac-bc21-f2ad822bb9de" />

---

## Task 2: Static Site Deployment with 4EVERLAND

**Objective**: Deploy a website to IPFS using 4EVERLAND's automation platform and manage continuous deployment workflows. 4EVERLAND simplifies deploying and managing websites on decentralized infrastructure, providing CI/CD-like workflows for Web3 hosting with automatic IPFS publishing.

1. **Set up 4EVERLAND project**:
   1. Sign up at [4EVERLAND.org](https://www.4everland.org/) (use GitHub or any wallet  like Metamask auth)
   2. Click "Create New Project" → "Connect GitHub repository"
   3. Select your current repository and branch or any real pet web app/site
   4. Configure build settings for this repo (if you use your own repo adjust configs):
      - Platform: IPFS/Filecoin
      - Framework: Other
      - Publish directory: `/app`
   5. Deploy!

2. **Verify deployment**:
   - In 4EVERLAND dashboard:
     - Note IPFS CID under "Site Info"
     - Access site via *.4everland.app subdomain
   - Verify on public gateway:
     `https://ipfs.io/ipfs/<CID-from-4EVERLAND>`

<img width="1702" height="763" alt="image" src="https://github.com/user-attachments/assets/80d2867b-ab0a-408f-8cfd-4314f585b194" />

Via public gateways:

https://Kulikova-A18.4everland.app/
https://bafybeihzarmfcsys5au2yx3mhemrowy2x4xg4pckz3s7rxbipa3etpsjzm.ipfs.dweb.link/

---

## Submission Guidelines

1. Create `submission10.md` with:

   ```markdown
   ## Task 1 Results
   - IPFS Node Peer Count: [Number from web UI]
   - IPFS Node Bandwidth: [Number from web UI]
   - Test File CID: [Your CID]
   - Public Gateway URL: [link]

   ## Task 2 Results
   - 4EVERLAND Project URL: [your-site.on..4everland.app]
   - GitHub Repository (if you used your own app): [github.com/your/repo]
   - IPFS CID from 4EVERLAND: [CID shown in dashboard]
   ```

2. Include screenshots of:
   - Successful access via local gateway (Task 1)
   - 4EVERLAND deployment dashboard (Task 2)
   - Site accessed through *.on.4EVERLAND.co domain

3. Submit via pull request.

> **Note**: IPFS propagation delays are normal. If public gateways don't work immediately, try on a next day.
