# Task 1
What I did:
- Created a `.github/workflows/github-actions-demo.yml`
- Used an example demo workflow from the quickstart
- Pushed the changes
- The workflow [ran](https://github.com/JustSomeDude2001/Sum25-intro-labs/actions/runs/15763560942/job/44435360621) as expected

Key concepts:
- GitHub actions allows running things on GitHub servers on specific triggers (such as push)
- The things you could run may include:
    - linters
    - tests
    - deployment
    - and other tests
- All things in a workflow are executed in a sequenctial order, until some item in a workflow fails
- This way workflows can be used to facilitate some degree of quality on the master branch, so that only items with workflows passing are pushed on the main branch.
