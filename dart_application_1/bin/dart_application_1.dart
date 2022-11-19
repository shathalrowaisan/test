import 'dart:io';

void main(List<String> arguments) {

  // the initial data
  Warehouse.books = [
    Book(book_title: "start with why", price: 80.0 , author: "simon sink" , quantity: 13) ,
    Book(book_title: "but how do it know", price: 59.9 , author: "j. clark scott" , quantity: 22) ,
    Book(book_title: "clean code", price: 50.0 , author: "robert cecil martin" , quantity: 5) ,
    Book(book_title: "zero to one", price: 45.0 , author: "peter thiel" , quantity: 12) ,
    Book(book_title: "you don't know js", price: 39.9 , author: "kyle simpson" , quantity: 9) ,
  ];

  print("=-" * 50);
  print("=-" * 50);

  // this var used to repeat the program in the while loop condition until the user choose to exit 
  bool repeat = true ;

  do {

    printCyan("1 . Add a new Book");
    printCyan("2 . Edit a Book");
    printCyan("3 . Delete a Book ");
    printCyan("4 . View the Books information");
    printCyan("5 . Search for a Book");
    printCyan("6 . buy a Book");
    printCyan("7 . Exit the program ");
    printBlue("-----------------------");
    stdout.write("Please enter a number from the about options : ");

    var input = stdin.readLineSync();

    print("-=" * 50);

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
        Warehouse.viewInfo();
        break;
      case "5":
        Warehouse.searchForBook();
        break;

      case "6":
        Warehouse.buyBook();
        break;

      case "7":
        repeat = false ;
        break;
      default:

        printRed("you didn't enter a number please try again. ");

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
  static viewInfo() {

    printCyan(
        '| ID   | Book Title                 | Author                     | Price   | Quantity  |');
    for (var book in books) {
      
      book.viewInfo();

    }
    
  }

  static addBook(){ 
    
    // -------------------------------READ BOOK TITLE------------------------------------------------
    
    stdout.write("Please enter the \x1B[35mBook title \x1B[0m: ");
    var bookTitle = stdin.readLineSync();


    // the book title is requierd so this loop to keep asking the user enter a valid book title
    while ( bookTitle!.isEmpty ) { 
      stdout.write("\x1B[31mPlease enter a ( valid ) Book title : \x1B[0m");
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
      stdout.write("\x1B[31mPlease enter a ( valid ) quantity : \x1B[0m");
      inputQuantity = stdin.readLineSync()!;
    }
    
    // since the input is string then we need to cast them to int
    int bookQuantity = int.parse(inputQuantity);

    if (bookFound == null) { // if it is a new book

      // -------------------------------READ BOOK AUTHOR------------------------------------------------
      
      stdout.write("Please enter the \x1B[35mBook author\x1B[0m : ");
      var bookAuther = stdin.readLineSync();

      // make the author lowercase to perform a good search result
      bookAuther = bookAuther!.toLowerCase().trim();

      // author is not requierd so if the uses didn't enter an input then the author will be unknown
      if (bookAuther.isEmpty) {
        bookAuther = "unknown" ;
      }

      // -------------------------------READ BOOK PRICE------------------------------------------------

      stdout.write("Please enter the \x1B[35mBook price\x1B[0m : ");
      var inputPrice = stdin.readLineSync()!;
      
      // validate the input
      while ( inputPrice.isEmpty || inputPrice.contains(RegExp(r'^[a-zA-Z_\-=@,\.;!#%^&*(){}$]+$')) ) {
        stdout.write("\x1B[31mPlease enter a valid Book price : \x1B[0m");
        inputPrice = stdin.readLineSync()!;
      }

      // since the input is string then we need to cast them to double
      double bookPrice = double.parse(inputPrice);
      
      // --------------------------------------------------------------------------------

      Warehouse.books.add( Book(book_title: bookTitle , price: bookPrice , author: bookAuther , quantity: bookQuantity) );
      printGreen("the Book with ID ( ${books.last.getID()} ) generated succesfully");


    } else { // when the book is already exist

      // incremnet the quantity then print the new
      bookFound.setQuantity(quantity: (bookFound.getQuantity()! + bookQuantity) );
      print("the \x1B[35mbook quantity\x1B[0m now is : ${bookFound.getQuantity()}");

    }

  } //end of addBook()

  static deleteBook(){
    
    viewInfo();

    // read input from the user
    stdout.write("Enter the \x1B[35mbook ID \x1B[0m to \x1B[31m delete \x1B[0m or \x1B[36mtype X\x1B[0m to return to the main menu : ");
    var input = stdin.readLineSync()!;

    if (input == "X" || input == "x") {
      return ; // for better user experience , the user can exit at any step
    } else {
      
      // validate the input
      while ( input.isEmpty || input.contains(RegExp(r'^[a-zA-Z_\-=@,\.;!#%^&*(){}$]+$')) ) {
        stdout.write("\x1B[31mPlease enter a ( valid Book ID ) or type X to return to the main menu : \x1B[0m");
        input = stdin.readLineSync()!;
        if (input == "X" || input == "x") {return ;}
      }
      int inputID = int.parse(input);

      // 
      if( !books.any((element) => element.getID() == inputID) ){ //check if there is a book or not
        printRed("there is no book with this ID");
      } else {
        printYellow("are you sure you want to delete this book ? "); // make sure that the user is sure
        int deleted = books.indexWhere((element) => element.getID() == inputID);
        books[deleted].viewInfo();
        stdout.write("type ( y ) for yes , or ( n ) for no : ");
        
        var sure = stdin.readLineSync()!.trim();
        if (sure == "N" || sure == "n" ) { // feadback for the user
          printGreen("nothing has been deleted");
        } else {
          books.removeAt(deleted);
          printGreen("Book deleted succesfully");
        }
        
      }
    }
    

  }//end of deleteBook()

  static searchForBook(){

    print("Please enter the \x1B[35m name of book\x1B[0m OR \x1B[35m author's name \x1B[0m: ");
    var input = stdin.readLineSync();
    
    while (input!.isEmpty) { // validate the input
      printRed("Please enter something to search");
      input = stdin.readLineSync();
    }
    
    input = input.toLowerCase().trim();

    for (var find in Warehouse.books) { // print the search result
      if (input == find.book_title || input == find.author) {
        printBlue("here is the book you asked for");
        find.viewInfo(); 
        break;
      }
    }
  }

  static editBook(){

    Warehouse.viewInfo();

    print("Enter the \x1B[35m ID \x1B[0m of the book you want to edit");
    var nID = stdin.readLineSync()!;

    // validate the input
    while ( nID.isEmpty || nID.contains(RegExp(r'^[a-zA-Z_\-=@,\.;!#%^&*(){}$]+$')) ) {
      stdout.write("\x1B[31mPlease enter a valid Book ID :\x1B[0m ");
      nID = stdin.readLineSync()!;
    }
    
    // since the input is string then we need to cast them to int
    int BookID = int.parse(nID);

    //check if already exist
    var index = books.indexWhere((element) => element.getID() == BookID) ;
    if ( index < 0 ) {
      printYellow("sorry there is no book with this ID");
    } else {
      print("choose what do you want to edit : ");
      print("1 . Book title");
      print("2 . Book price");
      print("3 . Book author");
      print("4 . Book quantity");
      print("Enter the option number : ");

      var input = stdin.readLineSync();

      switch (input) {
        case "1": // Book title
          print("the current title : ${books[index].getTitle()}"); //print the current book title
          stdout.write("New book title :");
          var newTitle = stdin.readLineSync();
          while(newTitle!.isEmpty){ // validate the input
            stdout.write("you didn't enter the title of the book. try again : ");
            newTitle = stdin.readLineSync();
          }
          newTitle = newTitle.toLowerCase().trim();
          Warehouse.books[index].setTitle(title: newTitle); // update 
          break;
        case "2": // Book price
          print("the current price : ${books[index].getPrice()}"); //print the current book price
          stdout.write("New book price :");
          var newPrice = stdin.readLineSync();
          while(newPrice!.isEmpty || newPrice.contains(RegExp(r'^[a-zA-Z_\-=@,\.;!#%^&*(){}$]+$'))){ // validate the input
            stdout.write("you didn't enter the price of the book. try again : ");
            newPrice = stdin.readLineSync();
          }
          Warehouse.books[index].setPrice(price: double.parse(newPrice)); // update 
          break;
        case "3": // Book author
          print("the current author : ${books[index].getAuthor()}"); //print the current book author
          stdout.write("New book author :");
          var newAuthor = stdin.readLineSync();
          while(newAuthor!.isEmpty){ // validate the input
            stdout.write("you didn't enter the author of the book. try again : ");
            newAuthor = stdin.readLineSync();
          }
          newAuthor = newAuthor.toLowerCase().trim();
          Warehouse.books[index].setAuthor(author: newAuthor); // update 
          break;
        case "4": // Book quantity
          print("the current quantity : ${books[index].getQuantity()}"); //print the current book quantity
          stdout.write("New book quantity :");
          var newQuantity = stdin.readLineSync();
          while(newQuantity!.isEmpty || newQuantity.contains(RegExp(r'^[a-zA-Z_\-=@,\.;!#%^&*(){}$]+$'))){ // validate the input
            stdout.write("you didn't enter the quantity of the book. try again : ");
            newQuantity = stdin.readLineSync();
          }
          Warehouse.books[index].setQuantity(quantity: int.parse(newQuantity)); // update 
          break;
        default:
      }
    }
  }

  static buyBook(){

    List<List> cart = [];

    bool anotherBook = true ;
    while(anotherBook){
      viewInfo();
      print("choose\x1B[35m by ID\x1B[0m which book you want to buy : ");
      var nID = stdin.readLineSync()!;

      // validate the input
      while ( nID.isEmpty || nID.contains(RegExp(r'^[a-zA-Z_\-=@,\.;!#%^&*(){}$]+$')) ) {
        stdout.write("\x1B[31mPlease enter a valid Book ID :\x1B[0m ");
        nID = stdin.readLineSync()!;
      }

      int ID = int.parse(nID);

      var index = books.indexWhere((element) => element.getID() == ID) ;
      if (index < 0) { // invalid id 
        print("there is no book with this ID ");
      }else{

        print("How many you need to buy from ${books[index].getID()} : "); // ask for quantity
        var quantitiy = stdin.readLineSync();

        while(quantitiy!.isEmpty || quantitiy.contains(RegExp(r'^[a-zA-Z_\-=@,\.;!#%^&*(){}$]+$'))){ // validate the input
          stdout.write("you didn't enter the quantity of the book. try again : ");
          quantitiy = stdin.readLineSync();
        }

        if (books[index].getQuantity() >= int.parse(quantitiy) ) { // check the quantity
          cart.add([ books[index] , int.parse(quantitiy) ]);
        }else{
          printRed("Sorry! we are out of stock");
        }


        print("do you want to buy another book ? ");
        stdout.write("type ( y ) for yes , or ( n ) for no : ");
        var another = stdin.readLineSync()!.trim();
        printBlue("-------------------------");
        if (another == "N" || another == "n" ) {
          anotherBook = false ;
        } 

        
      }
    }

    double total = 0 ;
    for (var item in cart) { // calculate the total price
      print("you bought ${item[1]} of this book :");
      item[0].viewInfo();
      printBlue("-------------------------");
      total = total + ( item[0].getPrice() * item[1]) ;
    }

    printCyan("your total invoice is : ${total}");

    printBlue("do you want to confirm your payment ? "); 
    stdout.write("type ( y ) for yes , or ( n ) for no : ");

    var confirm = stdin.readLineSync()!.trim();
    printBlue("-------------------------");
    if (confirm == "Y" || confirm == "y" ) {// confirm the payment to decrment the quantity
      for (var book in cart) {
        book[0].setQuantity(quantity: book[0].getQuantity() - book[1]);
      }
    }

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

  }
  

  // SETTERS AND GETTERS
  getQuantity(){ return quantity ;}
  setQuantity({required int quantity}){this.quantity = quantity;}

  getTitle(){return book_title ;}
  setTitle({required String? title}){book_title = title ;}

  getPrice(){return price ;}
  setPrice({required double price}){ this.price = price ;}

  getAuthor(){return author ;}
  setAuthor({required String author}){ this.author = author ;}

  // the book ID cannot use a setter since it cannot be changed
  getID(){return book_id;}



  viewInfo(){  // decorations for the print 

    String printID = book_id.toString() ;
    if (book_id.toString().length < 5) {
      printID = " ${book_id}";
    }
    stdout.write("|  ${printID}  |");

    String printT = book_title.toString() ;
    if (book_title.toString().length < 20) {
      printT = " ${book_title} ${ ' ' * ( 20 - book_title.toString().length )} ";
    }
    stdout.write("   ${printT}  |");

    String printA = author.toString() ;
    if (author.toString().length < 20) {
      printA = " ${author} ${ ' ' * ( 20 - author.toString().length )} ";
    }
    stdout.write("   ${printA}  |");

    String printP = price.toString() ;
    if (price.toString().length < 2) {
      printP = " ${price} ${ ' ' * ( 2 - price.toString().length )} ";
    }
    stdout.write("   ${printP}  |");

    String printQ = quantity.toString() ;
    if (quantity.toString().length < 3) {
      printQ = " ${quantity} ${ ' ' * ( 3 - quantity.toString().length )} ";
    }
    stdout.write("   ${printQ}  |");
   
    print("");

  }


}
