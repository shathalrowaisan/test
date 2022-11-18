
// import 'dart:html';
import 'dart:io';

void main(List<String> arguments) {

  // this var is used to repeat the program in the while loop condition until the user choose to exit 
  bool repeat = true ;

  do {

    print("1 . Add a new Book");
    print("2 . Edit a Book");
    print("3 . Delete a Book ");
    print("4 . view ");
    print("5 . search ");
    print("6 . Exit the program ");
    stdout.write("Please enter a number from the above options : ");

    var input = stdin.readLineSync();

    switch (input) {
      case "1":
        Warehouse.addBook();
        break;

      case "2":
        
        break;

      case "3":
        
        break;

      case "4":

        break;
      case "5":
        
        break;

      case "6":
        repeat = false ;
        break;
      
      default:
        print("-=" * 50);
        print("you didn't enter a number please try again. ");
    }
    
  } while (repeat);


}

abstract class Library with Warehouse{

  viewInfo(){
    
  }

  // addBook(); // I don't think that it is a good idea to use this method in both classes

}

mixin Warehouse {

  static late List<Book> books = [ 
    Book(book_title: "start with why", price: 80.0 , author: "simon sink" , quantitiy: 13) ,
    Book(book_title: "but how do it know", price: 59.9 , author: "j. clark scott" , quantitiy: 22) ,
    Book(book_title: "clean code", price: 50.0 , author: "robert cecil martin" , quantitiy: 5) ,
    Book(book_title: "zero to one", price: 45.0 , author: "peter thiel" , quantitiy: 12) ,
    Book(book_title: "you don't know js", price: 39.9 , author: "kyle simpson" , quantitiy: 9) ,
   ] ;
  
  @override
  static viewInfo() {
    // khuloud
    // this method should print all the books and all there info

    
  }

  static addBook(){ 
    // shatha
    // check if the book is already exist then add it to the list
    // if it's already exest then incrment the quantity
    

    // -------------------------------------------------------------------------------
    
    stdout.write("Please enter the Book title : ");
    var bookTitle = stdin.readLineSync();


    // the book title is requierd so this loop to keep asking the user enter a valid book title
    while ( bookTitle!.isEmpty ) { 
      stdout.write("Please enter a valid Book title : ");
      bookTitle = stdin.readLineSync();
    }

    // please check if the book exist or not by calling the method search
    // add if stetment one for the book that is exist and the else is for the new book
    // lower case and trim

    // --------------------------------------------------------------------------------


      stdout.write("Please enter the Book author : ");
      var bookAuther = stdin.readLineSync();

      if (bookAuther!.isEmpty) {
        bookAuther = "unknown" ;
      }


    // --------------------------------------------------------------------------------


    stdout.write("Please enter the Book price : ");
    var bookPrice = double.parse(stdin.readLineSync()!);
    print(bookPrice);
    // you have to check if the input is a number

    // --------------------------------------------------------------------------------

    stdout.write("How many Books you wants to add ? ");
    var bookQuantity = int.parse(stdin.readLineSync()!);
    print(bookQuantity);
    // you have to check if the input is a number


    // --------------------------------------------------------------------------------

    Warehouse.books.add( Book(book_title: bookTitle , price: bookPrice , author: bookAuther) );


  }

  static deleteBook(){
    // amjad
    // 

  }

  static searchForBook(){
    // amjad
    // search by the title 
    // return the ID

  }


}


class Book extends Library {

  static int ID_counter = 1 ; 
  int? book_id ;
  String? book_title ;
  String? author ;
  double? price ;
  int? quantity = 0;

  Book({ required this.book_title , String? author , required this.price , int? quantitiy }){
    if ( author != null ) {
      this.author = author ;
    }
    if ( quantity != null ) {
      this.quantity = quantitiy ;
    }
    this.book_id = ID_counter ;
    ID_counter = ID_counter + 1 ;
    print("the Book ID is : ${this.book_id}");
  }

  viewInfo(){ 
    // khuloud
    // view all the book info exept the quantitiy

  }

  addBook(){ 
    // shahta
    // takes all the new book info from the user and send them to the warehouse
    // an optional thing : the user can cancle the procces by using switch statment

  }

  edit(){ 
    // amjad
    // takes a multible parameters and check for null parameter
  }

}
