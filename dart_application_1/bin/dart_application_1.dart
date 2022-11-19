
// import 'dart:html';
import 'dart:collection';
import 'dart:io';
import 'dart:mirrors';

void main(List<String> arguments) {

  Warehouse.books = [
    Book(book_title: "start with why", price: 80.0 , author: "simon sink" , quantity: 13) ,
    Book(book_title: "but how do it know", price: 59.9 , author: "j. clark scott" , quantity: 22) ,
    Book(book_title: "clean code", price: 50.0 , author: "robert cecil martin" , quantity: 5) ,
    Book(book_title: "zero to one", price: 45.0 , author: "peter thiel" , quantity: 12) ,
    Book(book_title: "you don't know js", price: 39.9 , author: "kyle simpson" , quantity: 9) ,
  ];

  print("=-" * 50);
  print("=-" * 50);

  // this var is used to repeat the program in the while loop condition until the user choose to exit 
  bool repeat = true ;

  do {

    print("1 . Add a new Book");
    print("2 . Edit a Book");
    print("3 . Delete a Book ");
    print("4 . View the Books information");
    print("5 . Search for a Book");
    print("6 . Exit the program ");
    stdout.write("Please enter a number from the about options : ");

    var input = stdin.readLineSync();

    switch (input) {
      case "1":
        Warehouse.addBook();
        break;

      case "2":
        Warehouse.editBook();
        break;

      case "3":
        Warehouse.deleteBook();
        break;

      case "4":
        Warehouse.viewInfo(quantity: true);
        break;
      case "5":
        Warehouse.searchForBook();
        break;

      case "6":
        repeat = false ;
        break;
      
      default:
        print("-=" * 50);
        
        print("you didn't enter a number please try again. ");

        print("-=" * 50);
    }
    
  } while (repeat);


}

void printRed(String text) {
  print('\x1B[31m$text\x1B[0m');
}

void printGreen(String text) {
  print('\x1B[32m$text\x1B[0m');
}

void printYellow(String text) {
  print('\x1B[33m$text\x1B[0m');
}

void printBlue(String text) {
  print('\x1B[34m$text\x1B[0m');
}

void printMagenta(String text) {
  print('\x1B[35m$text\x1B[0m');
}

void printCyan(String text) {
  print('\x1B[36m$text\x1B[0m');
}

void printWhite(String text) {
  print('\x1B[37m$text\x1B[0m');
}

void printReset(String text) {
  print('\x1B[0m$text\x1B[0m');
}



abstract class Library with Warehouse{

  viewInfo();

}

mixin Warehouse {

  static late List<Book> books ;
  
  @override
  static viewInfo({required bool? quantity}) {
    // khuloud
    // this method should print all the books and all there info
   //print("the name of the book: ${book_title},the uathor:${author},the price: ${price} ");


    for (var book in books) {
      
      if (quantity!) {

        // print ID ( stdout.write() )
        stdout.write("${book.getID()} . ");
        book.viewInfo();
        // print quantity
        
      } else {
        
        book.viewInfo();

      }

    }
    
  }

  static addBook(){ 
    
    // -------------------------------READ BOOK TITLE------------------------------------------------
    
    stdout.write("Please enter the Book title : ");
    var bookTitle = stdin.readLineSync();


    // the book title is requierd so this loop to keep asking the user enter a valid book title
    while ( bookTitle!.isEmpty ) { 
      stdout.write("Please enter a valid Book title : ");
      bookTitle = stdin.readLineSync();
    }

    // make the title lowercase to perform a good search result
    bookTitle = bookTitle.toLowerCase().trim();
    
    // if the book is already exist then we should incrment the quantity only
    Book? bookFound ;
    for (var element in books) {
      if (element.book_title == bookTitle) {
        bookFound = element ;
      }
    }


    // -------------------------------READ BOOK QUANTITY------------------------------------------------

    stdout.write("How many Books you wants to add ? ");
    var inputQuantity = stdin.readLineSync()! ;

    // validate the input
    while ( inputQuantity.isEmpty || inputQuantity.contains(RegExp(r'^[a-zA-Z_\-=@,\.;!#%^&*(){}$]+$')) ) {
      stdout.write("Please enter a valid Book price : ");
      inputQuantity = stdin.readLineSync()!;
    }
    
    // since the input is string then we need to cast them to int
    int bookQuantity = int.parse(inputQuantity);

    if (bookFound == null) { // if it is a new book

      // -------------------------------READ BOOK AUTHOR------------------------------------------------
      
      stdout.write("Please enter the Book author : ");
      var bookAuther = stdin.readLineSync();

      // make the author lowercase to perform a good search result
      bookAuther = bookAuther!.toLowerCase().trim();

      // author is not requierd so if the uses didn't enter an input then the author will be unknown
      if (bookAuther.isEmpty) {
        bookAuther = "unknown" ;
      }

      // -------------------------------READ BOOK PRICE------------------------------------------------

      stdout.write("Please enter the Book price : ");
      var inputPrice = stdin.readLineSync()!;
      
      // validate the input
      while ( inputPrice.isEmpty || inputPrice.contains(RegExp(r'^[a-zA-Z_\-=@,\.;!#%^&*(){}$]+$')) ) {
        stdout.write("Please enter a valid Book price : ");
        inputPrice = stdin.readLineSync()!;
      }

      // since the input is string then we need to cast them to double
      double bookPrice = double.parse(inputPrice);
      
      // --------------------------------------------------------------------------------

      Warehouse.books.add( Book(book_title: bookTitle , price: bookPrice , author: bookAuther , quantity: bookQuantity) );

    } else { // when the book is already exist

      // incremnet the quantity then print the new
      bookFound.setQuantity(quantity: (bookFound.getQuantity()! + bookQuantity) );
      print("the book quantity now is : ${bookFound.getQuantity()}");

    }

  } //end of method addBook()

  static deleteBook(){
    // amjad
    // 

  }

  static searchForBook(){
    // amjad
    // search by the title 
    // return the ID

  }

  static editBook(){

  }


}


class Book extends Library {

  static int ID_counter = 1 ; 
  late final int? book_id ;
  String? book_title ;
  String? author ;
  double? price ;
  int? quantity = 0;

  Book({ required this.book_title , required this.author , required this.price , required this.quantity }){

    // generate the ID automatically
    book_id = ID_counter ;
    ID_counter = ID_counter + 1 ;
    print("the Book with ID ( $book_id ) generated succesfully");

  }
  

  // SETTERS AND GETTERS
  getQuantity(){ return quantity ;}
  setQuantity({required int quantity}){this.quantity = quantity;}

  getTitle(){return book_title ;}
  setTitle({required String? title}){book_title = title ;}

  getPrice(){return price ;}
  setPrice({required double price}){ this.price = price ;}

  getAuthor(){return price ;}
  setAuthor({required double price}){ this.price = price ;}

  // the book ID cannot use a setter since it cannot be changed
  getID(){return book_id;}



  viewInfo(){ 
    // khuloud
    print("the name of the book: ${book_title},the uathor:${author},the price: ${price} ");

  }

  edit(){ 
    // amjad
    // takes a multible parameters and check for null parameter
  }

}
