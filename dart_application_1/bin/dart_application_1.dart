
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

abstract class Library {

  viewInfo();

  addBook();

}

mixin Book implements Library {

  final int? book_id ;
  String? book_title ;
  const String? author ;
  double? price ;
  int? quantity ;

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

class Warehouse extends Library with Book {

  static late List<Book> books;
  
  @override
  viewInfo() {
    // khuloud
    
  }

  addBook(){ 
    // shatha
    // check if the book is already exest then add it to the list
    // if it's already exest then incrment the quantity

  }

  deleteBook(){
    // amjad
    // 

  }

  searchForBook(){
    // amjad
    // search by the title 
    // return the ID

  }


}
