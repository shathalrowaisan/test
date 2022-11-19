//import 'dart:html';
import 'dart:io';

void main(List<String> arguments) {
  // this var is used to repeat the program in the while loop condition until the user choose to exit
  bool repeat = true;

 
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
        Warehouse.deleteBook();

        break;

      case "4":
        break;
      case "5":
        Warehouse.searchForBook();
        break;

      case "6":
        repeat = false;
        break;

      default:
        print("-=" * 50);
        print("you didn't enter a number please try again. ");
    }
  } while (repeat);
}

abstract class Library with Warehouse {
  viewInfo() {}

  // addBook(); // I don't think that it is a good idea to use this method in both classes

}

mixin Warehouse {
  static late List<Book> books = [
    Book(
        book_title: "start with why",
        price: 80.0,
        author: "simon sink",
        quantitiy: 13),
    Book(
        book_title: "but how do it know",
        price: 59.9,
        author: "j. clark scott",
        quantitiy: 22),
    Book(
        book_title: "clean code",
        price: 50.0,
        author: "robert cecil martin",
        quantitiy: 5),
    Book(
        book_title: "zero to one",
        price: 45.0,
        author: "peter thiel",
        quantitiy: 12),
    Book(
        book_title: "you don't know js",
        price: 39.9,
        author: "kyle simpson",
        quantitiy: 9),
  ];

  @override
  static viewInfo() {
    // khuloud
    // this method should print all the books and all there info
  }

  static addBook() {
    // shatha
    // check if the book is already exist then add it to the list
    // if it's already exest then incrment the quantity

    // -------------------------------------------------------------------------------

    stdout.write("Please enter the Book title : ");
    var bookTitle = stdin.readLineSync();

    // the book title is requierd so this loop to keep asking the user enter a valid book title
    while (bookTitle!.isEmpty) {
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
      bookAuther = "unknown";
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

    Warehouse.books
        .add(Book(book_title: bookTitle, price: bookPrice, author: bookAuther));
  }

  static deleteBook() {
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

  static searchForBook() {
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
}

class Book extends Library {
  static int ID_counter = 1;
  int? book_id;
  String? book_title;
  String? author;
  double? price;
  int? quantity = 0;

  Book(
      {required this.book_title,
      String? author,
      required this.price,
      int? quantitiy}) {
    if (author != null) {
      this.author = author;
    }
    if (quantity != null) {
      this.quantity = quantitiy;
    }
    this.book_id = ID_counter;
    ID_counter = ID_counter + 1;
    print("the Book ID is : ${this.book_id}");
  }

  viewInfo() {
    // khuloud
    // view all the book info exept the quantitiy
  }

  addBook() {
    // shahta
    // takes all the new book info from the user and send them to the warehouse
    // an optional thing : the user can cancle the procces by using switch statment
  }



// I'm not sssuuuurrrreeee
  edit() {
    // amjad
    // takes a multible parameters and check for null parameter
    bool repeat = true;
    print(Warehouse.books);

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
          case "1":
            print("New book title :");
            var inputBE3 = stdin.readLineSync();
            inputBE3 = inputBE3!.toLowerCase().trim(); //الجدييييييد
            if (inputBE3.isEmpty) {
              print("you didn't enter the title of the book");
            } else {
              Warehouse.books[find]= inputBE3 as Book;
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
