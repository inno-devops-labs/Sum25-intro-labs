## Task 1 Results
- IPFS Node Peer Count: 17 (confirmed by peer list output)
- IPFS Node Bandwidth: Data unavailable (not displayed in web UI)
- Test File CID: QmNyiQsY3bKDLinnBWghYS6xz1gTV3W1hYiJ5j4CDfkBSw
- Public Gateway URL: https://ipfs.io/ipfs/QmNyiQsY3bKDLinnBWghYS6xz1gTV3W1hYiJ5j4CDfkBSw

## Task 2 Results
- Fleek Project URL: Not created (GitHub integration failed)
- GitHub Repository: Not connected
- IPFS CID from Fleek: Not obtained

## GitHub/Fleek Integration Issues
As shown in screenshot 4.png:
1. Fleek requires paid subscription ($20/month) for GitHub repository integration
2. Free plan restrictions:
   - "Prohibits sites for your repository" (blocks site creation)
   - Deployment requirement checks unavailable
3. Attempts to connect GitHub trigger "Upgrade your plan" prompt
4. Error message: "You cannot check deployment requirements without active subscription"

## Alternative Solution Implemented
Since Fleek integration failed due to payment requirements, I deployed the site manually via IPFS:

### Alternative Deployment Steps
1. Created simple website (`index.html`):
```html
<!DOCTYPE html>
<html>
<body>
   <h1>IPFS Hosting Alternative</h1>
   <p>Deployed manually via IPFS CLI</p>
</body>
</html>

2. Added to IPFS node:
docker cp index.html ipfs_node:/export/
docker exec ipfs_node ipfs add /export/index.html
> added QmRVSQ5W5a6kXxYzCCuFq7goyLd5dbfZ8q6T3dE6x7zD2C index.html

3. Accessed via gateway:
http://localhost:8080/ipfs/QmRVSQ5W5a6kXxYzCCuFq7goyLd5dbfZ8q6T3dE6x7zD2C
