import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:library_system/data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Library',
      theme: ThemeData(
        textTheme: Theme.of(context)
            .textTheme
            .apply(fontFamily: 'Sans', displayColor: Colors.black),
        primarySwatch: Colors.deepPurple,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Book> books = List.from(getBookList());
  List<Book> acbooks = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    acbooks = getBookList();
  }

  void filterList(value, fil) {
    setState(() {
      if (fil == 0) {
        acbooks = books
            .where((element) => element.title.toLowerCase().contains(value))
            .toList();
      } else if (fil == 1) {
        acbooks = books
            .where((element) =>
                element.author.fullname.toLowerCase().contains(value))
            .toList();
      } else if (fil == 2) {
        acbooks = books
            .where(
                (element) => element.description.toLowerCase().contains(value))
            .toList();
      }
    });
  }

  var fil = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(60, 30, 60, 30),
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              Row(
                children: [
                  SizedBox(width: 60),
                  _NavBarItem(title: 'Home'),
                  SizedBox(width: 60),
                  _NavBarItem(title: 'My Bookshelf')
                ],
              )
            ],
            toolbarHeight: 80,
            title: const Text('Library',
                style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'Bulgatti',
                    color: Colors.black87)),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(60, 30, 60, 30),
              child: Padding(
                padding: EdgeInsets.fromLTRB(40, 0, 40, 10),
                child: Column(
                  children: [
                    TextField(
                        onChanged: (value) => filterList(value, fil),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            prefixIconColor: Colors.purple,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            filled: true,
                            fillColor: Colors.purple[100],
                            hintText: 'Search by Name...')),
                    Row(
                      children: [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                fil = 0;
                              });
                            },
                            child: Text('Title')),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                fil = 1;
                              });
                            },
                            child: Text('Author')),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                fil = 2;
                              });
                            },
                            child: Text('Description'))
                      ],
                    ),
                    GridView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(10),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 2 / 2.85, crossAxisCount: 5),
                        itemCount: acbooks.length,
                        itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xFF242324),
                                    borderRadius: BorderRadius.circular(15.0),
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                          books.elementAt(index).image),
                                    )),
                              ),
                            )),
                  ],
                ),
              ),
            ),
          )

          // This trailing comma makes auto-formatting nicer for build methods.
          ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String title;

  const _NavBarItem({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, color: Colors.black87),
    );
  }
}
