import 'package:flutter/material.dart';
import 'package:hadith/classes.dart';
import 'package:hadith/hadith.dart';
import 'package:url_launcher/url_launcher.dart';

Collection hadith = getCollection(Collections.bukhari);
HadithData x = getHadithDataByNumber(Collections.bukhari, '2', Languages.en);
final Uri sunnahDotCom = Uri.parse('https://sunnah.com/bukhari');
const int numberOfBooks = 97;

String removePTags(String htmlContent) {
  // Remove all <p> tags using regex
  final regex = RegExp(r'<p>(.*?)<\/p>', multiLine: true, dotAll: true);
  final matches = regex.allMatches(htmlContent);

  // Join the extracted text from all matches
  final cleanedText = matches.map((match) {
    return match.group(1) ?? '';
  }).join('\n'); // You can change the separator if needed

  return cleanedText;
}

class BukhariPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //print(hadith);
    // print(getCollections()); // only shows abi dawud

    // Get a single collection
    //print(getCollection(Collections.bukhari)); // gives info about authors. not hadith itself
    // var bukhariCollection = getCollection(Collections.bukhari);

    // // Get collection data
    // print(getCollectionData(Collections.bukhari, Languages.en));

    // // Get books of a collection
    // print(getBooks(Collections.bukhari)[96].numberOfHadith); // gives info on books 1-6:name, hadithStartNumber ,endNumber and number of hadiths
    // print(getBooks(Collections.bukhari)[0].book[0].name);
    // // Get a single book
    // print(getBook(Collections.bukhari, 1));

    // // Get book data
    // print(getBookData(Collections.bukhari, 1, Languages.en));

    // // Get hadiths of a book
    // print(getHadiths(Collections.bukhari, 1)); // gets info on hadith, doesnt get all from book just first

    // // Get a single hadith
    // print(getHadith(Collections.bukhari, 1, 1)); // same as above

    // // Get hadith data
    // print(hadithStartNumberIntTest);
    // for (int i = 0; i <  97; i++) {
    //   print(i);
    //   print(getBooks(Collections.bukhari)[i].numberOfHadith);
    // } // this gets the book as first arg then the hadith number as second arg. better than above
    // print(getBooks(Collections.bukhari)[2].numberOfHadith);

    // // Get hadith data by hadith number
    // print(getHadithDataByNumber(Collections.bukhari, '1', Languages.en));
    // print(getHadithDataByNumber(Collections.muslim, '36 b', Languages.en));

    // // Get collection URL
    // print(getCollectionURL(Collections.bukhari));

    // // Get book URL
    // print(getBookURL(Collections.bukhari, 1));
    return Scaffold(
      appBar: AppBar(
        title: Text('Bukhari Page'),
      ),
      body:
          // Container(
          //   color: Color.fromARGB(255, 87, 86, 121),
          //   child:
          Scrollbar(
        thickness: 20,
        interactive: true,
        child:
            //   Column(
            // children: [
            //   Text(
            //     "Sahih al-Bukhari, compiled by Imam Muhammad al-Bukhari (rahimahullah), is a revered collection of hadith. Widely acknowledged by the majority of the global Muslim community, it stands as the most authentic repository of narrations from the Sunnah of Prophet Muhammad (peace be upon him). Comprising more than 7500 hadith (with repetitions), distributed across 97 volumes, this compilation is distinguished for its unparalleled reliability. The translation offered here is credited to Dr. M. Muhsin Khan.",
            //   ),
            //   // Url for Sunnah.com
            //   InkWell(
            //     onTap: () async {
            //       if (!await launchUrl(sunnahDotCom)) {
            //         print('Could not launch $sunnahDotCom');
            //         //! make a proper error message
            //       }
            //     },
            //     child: Text(
            //       'Click here to see all hadith',
            //       style: TextStyle(
            //         color: Colors.blue,
            //         decoration: TextDecoration.underline,
            //       ),
            //     ),
            //   ),

            // SizedBox(height: 20), // Add spacing between intro and buttons
            // ListView of Buttons
            ListView.builder(
          shrinkWrap: true,
          itemCount: numberOfBooks, // Number of buttons
          itemBuilder: (context, index) {
            String hadithStartNumberString =
                getBooks(Collections.bukhari)[index]
                    .hadithStartNumber
                    .toString();

            String hadithEndNumberString =
                getBooks(Collections.bukhari)[index].hadithEndNumber.toString();

            int numberOfHadithInt =
                getBooks(Collections.bukhari)[index].numberOfHadith;

            String numberOfHadith =
                getBooks(Collections.bukhari)[index].numberOfHadith.toString();

            String nameEnglish =
                getBooks(Collections.bukhari)[index].book[0].name.toString();

            String nameArabic =
                getBooks(Collections.bukhari)[index].book[1].name.toString();

            return Column(
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(1.5),
                  child: TextButton(
                    style: TextButton.styleFrom(
                        foregroundColor: const Color.fromARGB(255, 139, 97, 97),
                        backgroundColor:
                            const Color.fromARGB(255, 232, 235, 230)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BukhariPageDetails(
                              bookIndex: index + 1,
                              hadithIndex: index + 1,
                              numberOfHadithInBook: numberOfHadithInt),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment
                            .start, // Align children to the left
                        children: [
                          Text(
                            nameEnglish,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            nameArabic,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Add spacing between buttons
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class BukhariPageDetails extends StatefulWidget {
  final int bookIndex;
  final int hadithIndex;
  final int numberOfHadithInBook;

  BukhariPageDetails(
      {required this.bookIndex,
      required this.hadithIndex,
      required this.numberOfHadithInBook});

  @override
  _BukhariPageDetailsState createState() => _BukhariPageDetailsState();
}

class _BukhariPageDetailsState extends State<BukhariPageDetails> {
  TextEditingController _hadithNumberController = TextEditingController();

  @override
  void dispose() {
    _hadithNumberController.dispose();
    super.dispose();
  }

  void _navigateToHadith() {
    // Get the Hadith number from the text field input
    int? selectedHadithNumber = int.tryParse(_hadithNumberController.text);

    // Check if the input is valid and within the range
    if (selectedHadithNumber != null &&
        selectedHadithNumber >= 1 &&
        selectedHadithNumber <= widget.numberOfHadithInBook) {
      // Navigate to the selected Hadith (You can implement your navigation logic here)
      // For example, you can use Navigator to push a new page with the selected Hadith.
      // Navigator.push(context, MaterialPageRoute(builder: (context) => HadithPage(selectedHadithNumber)));

      // Clear the text field after navigation
      _hadithNumberController.clear();
    } else {
      // Handle invalid input (e.g., show a message to the user)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid Hadith number'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];

    for (int i = 1; i <= widget.numberOfHadithInBook; i++) {
      String currentHadith =
          getHadithData(Collections.bukhari, widget.bookIndex, i, Languages.en).body;
      String currentHadithNumberString = i.toString(); // Get the current Hadith number
      widgets.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align the Hadith number to the left
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blue, // Change the background color
                borderRadius: BorderRadius.circular(10.0), // Make the container rounded
              ),
              padding: EdgeInsets.all(8.0),
              child: Text(
                "$currentHadithNumberString\n${removePTags(currentHadith.toString())}",
                style: TextStyle(
                  fontSize: 20.0, // Make the number bigger
                  color: Colors.white, // Change the text color
                ),
              ),
            ),
            if (i < widget.numberOfHadithInBook) // Add the divider for all items except the last
              Divider(
                thickness: 1.0, // Adjust the line thickness
              ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Bukhari Page Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _hadithNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Hadith Number',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _navigateToHadith,
                ),
              ),
            ),
            ...widgets, // Add the widgets to the Column
          ],
        ),
      ),
    );
  }
}