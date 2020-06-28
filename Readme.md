# Github Follower 

This app let's you look through github accounts and see all the followers linked. At the same time it let's you see complete information of each account as the name, bio, gists, etc.

## Technical description
The apps uses custom and modular views recycled across all the pages in the app. All the network petitions are managed by the native URLSession API and images are cached in order to optimize network load. 

The collection view used to display the user avatars are managed by the Diffable Data Source, so all the changes are managed with all new animations from iOS ecosystem. 
