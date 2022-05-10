import 'package:flutter/material.dart';

class AccountItem extends StatelessWidget {
  //final Movie movie;
  //final Function itemClick;

  const AccountItem({
    Key? key,
    //required this.movie,
    //required this.itemClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      //onTap: () => itemClick(movie),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    /*child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      placeholder: (context, url) => SizedBox(
                        child: Image.asset("assets/images/load.png"),
                      ),
                      imageUrl: movie.imageUrl!,
                      errorWidget: (context, url, error) {
                        print(error);
                        return Icon(
                          Icons.error,
                          color: Colors.red,
                        );
                      },
                    ),*/
                  )),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*Text(
                        movie.movieName!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),*/
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          /*Expanded(
                              flex: 0,
                              child: Text(movie.movieYear!.toString() + ",")),
                          Expanded(
                            flex: 1,
                            child: Text(
                              movie.movieDirector!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )*/
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      /*Text(
                        movie.movieDescription!,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.justify,
                      ),*/
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
