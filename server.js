//jshint esversion:6

const express = require('express');
const bodyparser = require('body-parser');
const mongoose = require('mongoose');
const utilities = require('./utilityFunctions.js');
const dbInfo = require('./db_conn.js');

//=========== connect to MongoDB ==============
mongoose.connect(dbInfo.dbUrl + "/" + dbInfo.database, { useNewUrlParser: true})
.catch((err) => console.error(err));

//=========== app setup =============
const app = express();
app.use(bodyparser.urlencoded({extended: true})); //allows the express instance to use body parser on nested objects, and exposes req.body ( a parsed verison of the HTTP request object sent from the client )
var PORT = 3000;

//========= mongoose handling.. ============
const bookSchema = new mongoose.Schema({
    isbn: String,
    comment: String
});

//create mongoose book model
const Book = mongoose.model("Book", bookSchema, "book");



//========== routes ================
app.get("/books", (req, res) => {
    //console.log(request);
    res.sendFile(__dirname + "/index.html");
}); //Response for a GET request

app.post("/books", async (req, res) => {
    let searchKey = utilities.toggleSearchKey(req)
    let lookupField = searchKey[0]; let lookupValue = searchKey[1]; 
    var result; 

    switch(lookupField){ 
        case "isbn":
            result = await Book.find({'isbn' : lookupValue});
            break;
        case "title":
            result = await Book.find({'title' : lookupValue});
            break;
        case "author":
            result = await Book.find({'author' : lookupValue});
            break;
        case "publisher":
            result = await Book.find({'publisher' : lookupValue});
            break;                
        default:
            console.log("Could not interpret search criteria: " + lookupValue);
    }

    res.json(result);
});

//listen on PORT 3000
app.listen(PORT, () => {
    console.log("server started on port " + PORT);
});

/*
function searchByISBN(Book, isbn, isRegex){
    var foundBook = Book.find({'isbn': isbn}, (err, book) => {
        await if(err){console.log(err)}
        else{foundBook = book;}
    });
    console.log(foundBook)
    return (foundBook);  
}
*/