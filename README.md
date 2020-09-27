# liber-api - an api for a personal library

## Summary
This API serves 4 distinct purposes: 
1. To showcase working with MongoDB and Node.js
2. To give me an opportunity to work on documenting an API
3. Allows me to catalogue and comment on books in my wife and I's personal library. *This also conveniently gives me content to serve up on my website, echarlesgrasby.xyz*
4. To get more experience with deploying applications to AWS Lightsail

The data on these books was initially gathered by hand / gotten from manual Google searches. I couldn't find a *free* service to search for the data that I needed programmatically. However, 
if one comes available in the future, I'll probably either create a shell script to request data on future books via ISBN number and automatically update the master .csv file, or add an API route to programmatically use that service. 

## Components
* Node.js API - *currently* just exposes routes for retrieving documents out of a database
* MongoDB (standalone) database - stores book metadata (author, title, publisher, etc.)
* ```isbn.csv``` - master list of book metadata that is imported into MongoDB. ISBN (mix of ISBN-10 and ISBN-13) serves as the primary search key for the books in my library

## CSV Load
To load the isbn.csv file, utilize the mongoimport tool via the following shell command:

```mongoimport -d liber -c books --type csv --file .\isbn.csv --headerline```

## Resources

|Area    |URI    |
|:------:|:-----:|
|Yarn (Package Manager) documentation|https://yarnpkg.com/getting-started/install|
|Node Development Tutorials|https://mpolinowski.github.io/node-express-with-mongo-db#01-install-nodejs-and-expressjs-to-serve-our-web-application|

### Development Notes

Bulk loading a mongo collection from a .js file: 
(local devleopment) ```mongo 127.0.0.1:27017/liber insert_comments.js``` *You have to provide the absolute path to insert_comments.js*