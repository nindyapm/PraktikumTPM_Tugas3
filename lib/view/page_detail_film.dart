import 'package:flutter/material.dart';
import '../controller/api_data_source.dart';
import '../model/detail_film.dart';

class DetailFilms extends StatefulWidget {
  final String imdbID;

  const DetailFilms({required this.imdbID, Key? key}) : super(key: key);

  @override
  State<DetailFilms> createState() => _DetailFilmsState();
}

class _DetailFilmsState extends State<DetailFilms> {
  late Future<FilmDetail> _futureFilmDetail;

  @override
  void initState() {
    super.initState();
    _futureFilmDetail = ApiDataSource.instance.loadDetailFilm(widget.imdbID).then((json) => FilmDetail.fromJson(json));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Film"),
      ),
      backgroundColor: Colors.teal.withOpacity(0.5),
      body: _buildDetailBody(),
    );
  }

  Widget _buildDetailBody() {
    return Center(
      child: FutureBuilder<FilmDetail>(
        future: _futureFilmDetail,
        builder: (BuildContext context, AsyncSnapshot<FilmDetail> snapshot) {
          if (snapshot.hasError) {
            return Text("Error");
          }
          if (snapshot.hasData) {
            FilmDetail detailModel = snapshot.data!;
            return Column(
              children: [
                SizedBox(height: 15.0),
                Container(
                  width: 120.0,
                  height: 180.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: ClipRRect(
                    child: Image.network(
                      detailModel.poster!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  detailModel.title!,
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold,color: Colors.black),
                ),
                Container(
                  width: 500,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(fontSize: 16.0),
                          children: [
                            TextSpan(
                              text: "Date Released : ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: "${detailModel.released!}",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5.0),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(fontSize: 16.0),
                          children: [
                            TextSpan(
                              text: "Genre : ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: "${detailModel.genre!}",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5.0),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(fontSize: 16.0),
                          children: [
                            TextSpan(
                              text: "Director : ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: "${detailModel.director!}",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5.0),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(fontSize: 16.0),
                          children: [
                            TextSpan(
                              text: "Actor : ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: "${detailModel.actors!}",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5.0),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(fontSize: 16.0),
                          children: [
                            TextSpan(
                              text: "Language : ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: "${detailModel.language!}",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5.0),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(fontSize: 16.0),
                          children: [
                            TextSpan(
                              text: "Country : ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: "${detailModel.country!}",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5.0),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(fontSize: 16.0),
                          children: [
                            TextSpan(
                              text: "Awards : ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: "${detailModel.awards!}",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5.0),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(fontSize: 16.0),
                          children: [
                            TextSpan(
                              text: "Plot : ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: "${detailModel.plot!}",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}