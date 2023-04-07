import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Auth/auth_page.dart';
import 'full_info.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool isFavrate = false;

  final List<Map<String, dynamic>> _allBooks = [
    {
      "addfav": false,
      "isbn": "9781593279509",
      "title": "Eloquent JavaScript, Third Edition",
      "subtitle": "A Modern Introduction to Programming",
      "author": "Marijn Haverbeke",
      "published": "2018-12-04T00:00:00.000Z",
      "publisher": "No Starch Press",
      "pages": 472,
      "description":
          "JavaScript lies at the heart of almost every modern web application, from social apps like Twitter to browser-based game frameworks like Phaser and Babylon. Though simple for beginners to pick up and play with, JavaScript is a flexible, complex language that you can use to build full-scale applications.",
      "website": "http://eloquentjavascript.net/"
    },
    {
      "addfav": false,
      "isbn": "9781491943533",
      "title": "Practical Modern JavaScript",
      "subtitle": "Dive into ES6 and the Future of JavaScript",
      "author": "Nicolás Bevacqua",
      "published": "2017-07-16T00:00:00.000Z",
      "publisher": "O'Reilly Media",
      "pages": 334,
      "description":
          "To get the most out of modern JavaScript, you need learn the latest features of its parent specification, ECMAScript 6 (ES6). This book provides a highly practical look at ES6, without getting lost in the specification or its implementation details.",
      "website": "https://github.com/mjavascript/practical-modern-javascript"
    },
    {
      "addfav": false,
      "isbn": "9781593277574",
      "title": "Understanding ECMAScript 6",
      "subtitle": "The Definitive Guide for JavaScript Developers",
      "author": "Nicholas C. Zakas",
      "published": "2016-09-03T00:00:00.000Z",
      "publisher": "No Starch Press",
      "pages": 352,
      "description":
          "ECMAScript 6 represents the biggest update to the core of JavaScript in the history of the language. In Understanding ECMAScript 6, expert developer Nicholas C. Zakas provides a complete guide to the object types, syntax, and other exciting changes that ECMAScript 6 brings to JavaScript.",
      "website": "https://leanpub.com/understandinges6/read"
    },
    {
      "addfav": false,
      "isbn": "9781449365035",
      "title": "Speaking JavaScript",
      "subtitle": "An In-Depth Guide for Programmers",
      "author": "Axel Rauschmayer",
      "published": "2014-04-08T00:00:00.000Z",
      "publisher": "O'Reilly Media",
      "pages": 460,
      "description":
          "Like it or not, JavaScript is everywhere these days -from browser to server to mobile- and now you, too, need to learn the language or dive deeper than you have. This concise book guides you into and through JavaScript, written by a veteran programmer who once found himself in the same position.",
      "website": "http://speakingjs.com/"
    },
    {
      "addfav": false,
      "isbn": "9781449331818",
      "title": "Learning JavaScript Design Patterns",
      "subtitle": "A JavaScript and jQuery Developer's Guide",
      "author": "Addy Osmani",
      "published": "2012-08-30T00:00:00.000Z",
      "publisher": "O'Reilly Media",
      "pages": 254,
      "description":
          "With Learning JavaScript Design Patterns, you'll learn how to write beautiful, structured, and maintainable JavaScript by applying classical and modern design patterns to the language. If you want to keep your code efficient, more manageable, and up-to-date with the latest best practices, this book is for you.",
      "website":
          "http://www.addyosmani.com/resources/essentialjsdesignpatterns/book/"
    },
    {
      "addfav": false,
      "isbn": "9798602477429",
      "title": "You Don't Know JS Yet",
      "subtitle": "Get Started",
      "author": "Kyle Simpson",
      "published": "2020-01-28T00:00:00.000Z",
      "publisher": "Independently published",
      "pages": 143,
      "description":
          "The worldwide best selling You Don't Know JS book series is back for a 2nd edition: You Don't Know JS Yet. All 6 books are brand new, rewritten to cover all sides of JS for 2020 and beyond.",
      "website":
          "https://github.com/getify/You-Dont-Know-JS/tree/2nd-ed/get-started"
    },
    {
      "addfav": false,
      "isbn": "9781484200766",
      "title": "Pro Git",
      "subtitle": "Everything you neeed to know about Git",
      "author": "Scott Chacon and Ben Straub",
      "published": "2014-11-18T00:00:00.000Z",
      "publisher": "Apress; 2nd edition",
      "pages": 458,
      "description":
          "Pro Git (Second Edition) is your fully-updated guide to Git and its usage in the modern world. Git has come a long way since it was first developed by Linus Torvalds for Linux kernel development. It has taken the open source world by storm since its inception in 2005, and this book teaches you how to use it like a pro.",
      "website": "https://git-scm.com/book/en/v2"
    },
    {
      "addfav": false,
      "isbn": "9781484242216",
      "title": "Rethinking Productivity in Software Engineering",
      "subtitle": "",
      "author": "Caitlin Sadowski, Thomas Zimmermann",
      "published": "2019-05-11T00:00:00.000Z",
      "publisher": "Apress",
      "pages": 310,
      "description":
          "Get the most out of this foundational reference and improve the productivity of your software teams. This open access book collects the wisdom of the 2017 \"Dagstuhl\" seminar on productivity in software engineering, a meeting of community leaders, who came together with the goal of rethinking traditional definitions and measures of productivity.",
      "website": "https://doi.org/10.1007/978-1-4842-4221-6"
    }
  ];

  List<Map<String, dynamic>> _foundBooks = [];
  List<Map<String, dynamic>> favbook = [];
  @override
  void initState() {
    // TODO: implement initState
    _foundBooks = _allBooks;
    super.initState();
  }

  void _searchBooks(String searchKeyword) {
    List<Map<String, dynamic>> results = [];
    if (searchKeyword.isEmpty) {
      results = _allBooks;
    } else {
      results = _allBooks.where((book) {
        return book['title'].toLowerCase().contains(
                  searchKeyword.toLowerCase(),
                ) ||
            book['author'].toLowerCase().contains(
                  searchKeyword.toLowerCase(),
                );
      }).toList();
    }
    setState(() {
      _foundBooks = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Books'),
          actions: [
            IconButton(
              onPressed: () {
                Get.defaultDialog(
                    title: "Wanna LogOut 👋 ",
                    titleStyle: TextStyle(color: Colors.red),
                    backgroundColor: Colors.grey.shade600,
                    content: Text(
                      'After logout you can login through registered email and password',
                      style: TextStyle(color: Colors.white),
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text('No')),
                      ElevatedButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            Get.to(AuthPage());
                          },
                          child: Text('Yes')),
                    ]);
              },
              icon: Icon(Icons.logout),
            )
          ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 70,
                child: Center(
                  child: TextField(
                    onChanged: (value) => _searchBooks(value),
                    decoration: InputDecoration(
                      labelText: 'Search book',
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 1.3,
              child: ListView.builder(
                  itemCount: _foundBooks.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black,
                              width: 0.5,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(
                              Information(
                                  titile: _foundBooks[index]["title"],
                                  subtitile: _foundBooks[index]["subtitle"],
                                  author: _foundBooks[index]["author"],
                                  publisher: _foundBooks[index]["publisher"],
                                  published: _foundBooks[index]["published"],
                                  page: _foundBooks[index]["pages"],
                                  description: _foundBooks[index]
                                      ["description"]),
                            );
                          },
                          child: ListTile(
                            title: Text(
                              '${_foundBooks[index]['title']}',
                              style: TextStyle(
                                  color: Colors.blue.shade900,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${_foundBooks[index]['subtitle']}'),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${_foundBooks[index]['author']}',
                                    style: GoogleFonts.lato(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            trailing: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _foundBooks[index]['addfav'] =
                                      !_foundBooks[index]['addfav'];
                                });
                              },
                              child: Icon(
                                _foundBooks[index]['addfav']
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
