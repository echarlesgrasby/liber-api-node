//============= utility functions =====================
function toggleSearchKey(reqObject){
    //return search based on priority
    if(reqObject.body.isbn){ return ["isbn", reqObject.body.isbn]; }
    if(reqObject.body.title){ return ["title", reqObject.body.title]; }
    if(reqObject.body.author){ return ["author",reqObject.body.author]; }
    if(reqObject.body.publisher){ return ["publisher",reqObject.body.publisher]; }
};


/*
//db function
function searchByISBN(Book, isbn, isRegex){
    Book.find({'isbn':isbn}, function(err, item){
        if(err){console.log(err)}
        else{return item}
    });
}*/

//db function
function searchByAuthor(author, isRegex){

}
//db function
function searchByPublisher(author, isRegex){

}

//export the functions to a calling program
module.exports = {
    toggleSearchKey,
    //searchByISBN
}