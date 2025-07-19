## Task 1

**Start IPFS container**

~~~bash
docker run -d --name ipfs_node \
-v ipfs_staging:/export \
-v ipfs_data:/data/ipfs \
-p 4001:4001 -p 8080:8080 -p 5001:5001 \
ipfs/kubo:latest
~~~

~~~bash
Digest: sha256:51dd374d5a6a7e1a7c77358701d65bbf558a2e76802d65d4f81b125877811ee1
Status: Downloaded newer image for ipfs/kubo:latest
d86de217ca7da34c0c27e8cc4c85db07916f0ce843862dd5db9c42de35587fd0
~~~

**Verify node operation**

~~~bash
docker exec ipfs_node ipfs swarm peers
~~~

~~~bash
/ip4/101.33.81.69/tcp/39131/p2p/QmXisskEpAPqS2iUh9mXBxjGiH1pk7WpjKMibLMQWvpmCN
/ip4/101.47.182.44/tcp/44275/p2p/QmQzsSJ4SXfR8QxmUzfpuexrNbyHRE26M2LgjwheHwP3tM
/ip4/104.207.153.186/udp/4001/quic-v1/p2p/12D3KooWMeNjZppAeDHwhL8fB4CH1LFjKCweYKt4PSAp2DKPzgWR
...
~~~

**Add file to IPFS**

~~~bash
echo "Hello IPFS Lab" > testfile.txt
docker cp testfile.txt ipfs_node:/export/
docker exec ipfs_node ipfs add /export/testfile.txt
~~~

~~~bash
Successfully copied 2.05kB to ipfs_node:/export/
added QmUFJmQRosK4Amzcjwbip8kV3gkJ8jqCURjCNxuv3bWYS1 testfile.txt
~~~

![alt text](image.png)

![alt text](image-1.png)

Via public gateways:
- `https://dweb.link/ipfs/QmUFJmQRosK4Amzcjwbip8kV3gkJ8jqCURjCNxuv3bWYS1`

## Task 2

![alt text](image-2.png)

Via public gateways:
- `https://devops-course-t1shrogc-slauva.4everland.app/`
- `https://bafybeihzarmfcsys5au2yx3mhemrowy2x4xg4pckz3s7rxbipa3etpsjzm.ipfs.dweb.link/`