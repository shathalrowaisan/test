
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
        
        printMagenta("you didn't enter a number please try again. ");

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
        stdout.write("ID ${book.getID()} . ");
        book.viewInfo();
        stdout.write("ID ${book.getQuantity()} . ");
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
    bool repeat = true; //&&&&&&&&&&&&&&&&&&&&&&

    print(
        "View existing books ENTER 1 , cancel ENTER 2"); //النص الاول من الجمله غلط
    var input4 = stdin.readLineSync();

    switch (input4) {
      case "1":
        //هنا بعرض كل الكتب بمعلوماتها يعني بنادي ميثود فيوانفو
        print("Enter the book ID to delete");
        int? n1 = int.parse(stdin.readLineSync()!);
        //هنا فيه فكره ومشكله الفكره لو ما دخل اي دي موجود والمشكله ان لازم يطلع من اللوب
        books.removeWhere((element) => element.book_id == n1);
        print(books);

        break;

      case "2":
        repeat = false;
        break;
    }
  }

  static searchForBook(){
    // amjad
    // search by the title
    // return the ID
    bool repeat = true; //&&&&&&&&&&&&&&&&&&&&&&

    do {
      print(
          "If you want to search for the title of the book OR author's name ENTER 1 , cancel ENTER 2 ");
      var input5 = stdin.readLineSync();

      switch (input5) {
        case "1":
          print("Please enter the name of book OR author's name : ");
          var input6 = stdin.readLineSync();
          input6 = input6!.toLowerCase().trim();

          for (var find in Warehouse.books) {
            if (input6 == find.book_title || input6 == find.author) {
              print(find); //مومتأكده
            } else if (input6.isEmpty) {
              print("Please enter something to search");
            } else {
              print(
                  "Sorry there is no book title OR author's name in our library. We will work to provide it as soon as possible");
            }
          }
          break;

        case "2":
          repeat = false;
          break;
      }
    } while (repeat);
  }

  static editBook(){

    // amjad
    // takes a multible parameters and check for null parameter
    bool repeat = true;
    Warehouse.viewInfo(quantity: true);

    // print("Enter the title of the book you want to edit");
    // var inputBE = stdin.readLineSync();
    // inputBE = inputBE!.toLowerCase().trim(); //اسم الكتااااااااب
    print("Enter the ID of the book you want to edit");
    int? nID = int.parse(stdin.readLineSync()!);

    //check if already exist

    for (var find = 1; find < Warehouse.books.length; find++) {
      //if (find.book_title == inputBE)
      if (nID == find) {
        print(
            " if you want to change the title of the book ENTER 1,if you want to change the price of the book Enter 2,if you want to change the author Enter 3,if you want to change the quantity Enter 4, cancel ENTER 5");
        var inputBE2 = stdin.readLineSync();

        switch (inputBE2) {
          case "1": //title
            print("New book title :");
            var inputBE3 = stdin.readLineSync();
            inputBE3 = inputBE3!.toLowerCase().trim(); //الجدييييييد
            if (inputBE3.isEmpty) {
              print("you didn't enter the title of the book");
            } else {
              Warehouse.books[find-1]= inputBE3 as Book;
              // Warehouse.books[find-1].setTitle(title: inputBE3);
            }

            break;

          case "2":
            print("new price : ");
            var inputBE4 = double.parse(stdin.readLineSync()!);
            Warehouse.books[find]= inputBE4 as Book;
            
            break;

          case "3":
            print("the name of the author : ");
            var inputBE5 = stdin.readLineSync();
            inputBE5 = inputBE5!.toLowerCase().trim();
            if (inputBE5.isEmpty) {
              print("you didn't enter the title of the book");
            } else {
              Warehouse.books[find]= inputBE5 as Book;
            }
            break;

          case "4":
            print("The new quantity");
            var inputBE6 = double.parse(stdin.readLineSync()!);
            //بشيك اذا دخل رقم
            Warehouse.books[find]= inputBE6 as Book;
            
            break;

          case "5":
            repeat = false;
            break;

          default:
            print("you didn't enter a number please try again. ");
        }
      }
    }
    print(Warehouse.books);

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
    print("the titel book is : ${book_title}");
    print("    the name uathor:  ${author}");
     print("    the price:    ${price} ");
     print("    the amount of books available: ${quantity}");
     print(".............................................................");
  
  }


}
