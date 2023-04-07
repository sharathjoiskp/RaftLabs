import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class Information extends StatefulWidget {
  Information(
      {required this.titile,
      required this.subtitile,
      required this.author,
      required this.publisher,
      required this.published,
      this.page,
      required this.description,
      super.key});

  String titile;
  String subtitile;
  String author;
  String publisher;
  String published;
  int? page;
  String description;

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Full Desp'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 3.5,
                child: Image.network(
                    'https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T1/images/I/71IBxmk3cpL.jpg'),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        widget.titile,
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.w500, fontSize: 24),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Text(
                        widget.subtitile,
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        'by - ${widget.author}',
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.w800, fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow.shade900,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow.shade900,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow.shade900,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow.shade900,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow.shade900,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '5',
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.w400, fontSize: 25),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        widget.description,
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 4),
                      child: Text(
                        'Pages : ${widget.page}',
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 4),
                      child: Text(
                        'Published : ${widget.published.substring(0, 10)}',
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 4),
                      child: Text(
                        'Published by : ${widget.publisher}',
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
