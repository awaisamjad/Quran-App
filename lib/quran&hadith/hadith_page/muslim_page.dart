import 'package:flutter/material.dart';
import 'package:hadith/classes.dart';
import 'package:hadith/hadith.dart';
import 'package:url_launcher/url_launcher.dart';

Collection hadith = getCollection(Collections.muslim);
HadithData x = getHadithDataByNumber(Collections.muslim, '2', Languages.en);
final Uri sunnahDotCom = Uri.parse('https://sunnah.com/muslim');
const int numberOfBooks = 56;

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

class MuslimPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // print(getCollections()); // only shows abi dawud

    // Get a single collection
    // print(getCollection(Collections.muslim)); // gives info about authors. not hadith itself
    // var MuslimCollection = getCollection(Collections.Muslim);


    // // Get books of a collection
    // print(getBooks(Collections.muslim)[45].book); // gives info on books 1-6:name, hadithStartNumber ,endNumber and number of hadiths
    // print(getBooks(Collections.muslim)[0].book[0].name);
    // // Get a single book
    // print(getBook(Collections.muslim, 1));

    // // Get book data
    // print(getBookData(Collections.Muslim, 1, Languages.en));

    // // Get hadiths of a book
    // print(getHadiths(Collections.muslim, 1)); // gets chapter id, hadith number as 8a, hadith and urn,

    // // Get a single hadith
    // print(getHadith(Collections.muslim, 1, 1)); // same as above
    
    // // Get hadith data
    // print(hadithStartNumberIntTest);
    // int hadithStartNumberIntTest = getBooks(Collections.bukhari)[0].hadithStartNumber;
    // int hadithEndNumberIntTest = getBooks(Collections.bukhari)[0].hadithEndNumber;
    // for (int i = 1; i <= hadithEndNumberIntTest - hadithStartNumberIntTest; i++) {
    //   print(getHadithData(Collections.muslim, 1, i, Languages.en));
    // } // this gets the book as first arg then the hadith number as second arg. better than above

    // // Get hadith data by hadith number
    // print(getHadithDataByNumber(Collections.Muslim, '1', Languages.en));
    // print(getHadithDataByNumber(Collections.muslim, '36 b', Languages.en));

    // // Get collection URL
    // print(getCollectionURL(Collections.Muslim));

    // // Get book URL
    // print(getBookURL(Collections.Muslim, 1));
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 232, 235, 230),
      appBar: AppBar(
        title: Text('Muslim Page'),
      ),
      body: Scrollbar(
        thickness: 20,
        interactive: true,
        child: Center(
          child: Column(
            children: [
              //~ Container for intro
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 123, 189, 52),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      "Sahih Muslim is a collection of hadith compiled by Imam Muslim ibn al-Hajjaj al-Naysaburi (rahimahullah). His collection is considered to be one of the most authentic collections of the Sunnah of the Prophet (ﷺ), and along with Sahih al-Bukhari forms the 'Sahihain,' or the 'Two Sahihs.' It contains roughly 7500 hadith (with repetitions) in 57 books. The translation provided here is by Abdul Hamid Siddiqui.",
                    ),
                    //~ Url for Sunnah.com
                    InkWell(
                      onTap: () async {
                        if (!await launchUrl(sunnahDotCom)) {
                          print('Could not launch $sunnahDotCom');
                          //! make a proper error message
                        }
                      },
                      child: Text(
                        'Click here to see all hadith',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20), // Add spacing between intro and buttons
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: numberOfBooks, // Number of buttons
                  itemBuilder: (context, index) {
                    int hadithStartNumberInt =
                        getBooks(Collections.muslim)[index].hadithStartNumber;
                    String hadithStartNumberString =
                        getBooks(Collections.muslim)[index]
                            .hadithStartNumber
                            .toString();

                    int hadithEndNumberInt =
                        getBooks(Collections.muslim)[index].hadithEndNumber;

                    String hadithEndNumberString =
                        getBooks(Collections.muslim)[index]
                            .hadithEndNumber
                            .toString();

                    //print(hadithEndNumberInt - hadithStartNumberInt + 1);

                    String numberOfHadith = getBooks(Collections.muslim)[index]
                        .numberOfHadith
                        .toString();
                    String nameEnglish = getBooks(Collections.muslim)[index]
                        .book[0]
                        .name
                        .toString();
                    String nameArabic = getBooks(Collections.muslim)[index]
                        .book[1]
                        .name
                        .toString();

                    return Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MuslimPageDetails(
                                  bookIndex: index + 1,
                                  hadithIndex: index + 1,
                                  numberOfHadithInBook: hadithEndNumberInt -
                                      hadithStartNumberInt ,
                                ),
                              ),
                            );
                          },
                          child: Text(
                              '$nameEnglish  $nameArabic  $numberOfHadith hadiths     $hadithStartNumberString - $hadithEndNumberString'),
                        ),
                        SizedBox(height: 20), // Add spacing after the button
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MuslimPageDetails extends StatelessWidget {
  final int bookIndex;
  final int hadithIndex;
  final int numberOfHadithInBook;

  MuslimPageDetails(
      {required this.bookIndex,
      required this.hadithIndex,
      required this.numberOfHadithInBook});

  @override
  Widget build(BuildContext context) {
    StringBuffer hadithBuffer = StringBuffer();
    for (int i = 1; i <= numberOfHadithInBook ; i++) {
      String currentHadith =
          getHadithData(Collections.muslim, bookIndex, i, Languages.en).body;
      hadithBuffer.write(currentHadith);
      print(numberOfHadithInBook);
    }
    String hadith = hadithBuffer.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text('Muslim Page Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              removePTags(hadith),
            ),
          ],
        ),
      ),
    );
  }
}
