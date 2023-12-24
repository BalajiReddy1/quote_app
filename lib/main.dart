import 'dart:math';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(DailyQuotesApp());
}

class DailyQuotesApp extends StatelessWidget {
  const DailyQuotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Daily Quotes',
      home: DailyQuotesScreen(),
    );
  }
}

class DailyQuotesScreen extends StatefulWidget {
  const DailyQuotesScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DailyQuotesScreenState createState() => _DailyQuotesScreenState();
}

class _DailyQuotesScreenState extends State<DailyQuotesScreen> {
  final List<String> quotes = [
    "You are in danger of living a life so comfortable and soft, that you will die without ever realizing your true potential. ~ David Goggins",
    "Human strength lies in the ability to change yourself. ~ Saitama",
    "You can die anytime, but living takes true courage. ~ Kenshin Himura",
    "Be more than motivated, be more than driven, become literally obsessed to the point where people think you're fucking nuts. ~ David Goggins",
    "If you don't take risks, you can't create a future. ~ Monkey D. Luffy",
    "Like I always say, can't find a door? Make your own. ~ Edward Elric",
    "People who continue to put their lives on the line to defend their faith become heroes and continue to exist on in legend. ~ Naruto Uzumaki",
    "Forgetting is like a wound. The wound may heal, but it has already left a scar. ~ Monkey D. Luffy",
  ];

  String currentQuote = "";
  bool isFavorite = false;
  List<String> favoriteQuotes = [];

  @override
  void initState() {
    super.initState();
    getRandomQuote();
  }

  void getRandomQuote() {
    setState(() {
      final random = Random();
      final randomIndex = random.nextInt(quotes.length);
      currentQuote = quotes[randomIndex];
      isFavorite = favoriteQuotes.contains(currentQuote);
    });
  }

  void shareQuote() {
    Share.share(currentQuote);
  }

  void toggleFavorite() {
    setState(() {
      if (isFavorite) {
        favoriteQuotes.remove(currentQuote);
        Fluttertoast.showToast(
          msg: "Removed from Favorites",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      } else {
        favoriteQuotes.add(currentQuote);
        Fluttertoast.showToast(
          msg: "Added to Favorites",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      }
      isFavorite = !isFavorite;
    });
  }

  void showFavorites() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FavoritesScreen(favoriteQuotes),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Quotes'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: getRandomQuote,
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: showFavorites,
          ),
          IconButton(
            icon: Icon(
              Icons.share,
              color: isFavorite ? Colors.red : null,
            ),
            onPressed: shareQuote,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              currentQuote,
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: isFavorite ? Colors.red : null,
              ),
              onPressed: toggleFavorite,
            ),
          ],
        ),
      ),
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  final List<String> favoriteQuotes;

  FavoritesScreen(this.favoriteQuotes);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Quotes'),
      ),
      body: ListView.builder(
        itemCount: favoriteQuotes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(favoriteQuotes[index]),
          );
        },
      ),
    );
  }
}
