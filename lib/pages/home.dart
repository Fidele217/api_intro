import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Home extends StatelessWidget {

  Widget Top=Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const SizedBox(
        height: 50,
      ),
      Image.asset(
        'img/img.png',
        width: 150,
      ),
      const Text("Pour",
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w900,
        ),),
      const Text("Nous Tous",
        style: TextStyle(
            fontSize: 17,
            fontFamily: "Raleway",
            color: Colors.grey
        ),),
    ],
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor:const Color.fromARGB(243, 243, 243, 243),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                  height: 400,
                  width: 500,
                  color:const Color.fromARGB(243, 243, 243, 243),
                  child:FadeInUp(
                    child: Top,
                  )
              ),
              Expanded(
                  child: Container(
                    width: 500,
                    color: const Color.fromARGB(255, 17, 18, 26),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FadeInLeft(
                          child:ElevatedButton.icon(
                              onPressed: () {
                                Navigator.of(context).pushReplacementNamed("list_user");
                              },
                              style:ElevatedButton.styleFrom(
                                primary:const Color.fromARGB(255, 11, 11, 19),
                                onPrimary: Colors.white,
                                shadowColor: Colors.white60,
                                elevation: 5,
                                shape: const StadiumBorder(),
                              ),
                              icon:const FaIcon(FontAwesomeIcons.userAstronaut),
                              label: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text("List des users",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 23,
                                    )
                                ),
                              )
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        FadeInRight(
                          child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.of(context).pushReplacementNamed("add_user");
                              },
                              style:ElevatedButton.styleFrom(
                                primary:const Color.fromARGB(255, 11, 11, 19),
                                onPrimary: Colors.white,
                                shadowColor: Colors.white60,
                                elevation: 5,
                                shape: const StadiumBorder(),
                              ),
                              icon:const FaIcon(FontAwesomeIcons.userPlus),
                              label: const Padding(
                                padding: EdgeInsets.only(top:10.0, bottom:10.0, right:30.0,left: 30.0),
                                child: Text("S'enregistrer",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 23,
                                    )
                                ),
                              )
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text("Enregistrz vous pour tout planifier🍃",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Raleway",
                            )
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                      ],
                    ),

                  )
              )

            ]
        )
    );
  }
}
