import 'package:flutter/material.dart';
import '../Https/network.dart';
import '../Classes/Arguments/UserArguments.dart';
import '../Classes/User.dart';
import '../components/appbar.dart';
import '../pages/home.dart';
import '../pages/Add.dart';
import '../pages/Liste.dart';


class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "UserList",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      onGenerateRoute: (settings) {
        final args = ModalRoute.of(context)!.settings.arguments as UserArguments;

        return MaterialPageRoute(
            builder: (context) {
              return MainScreen(idUser: args.id, fullName: args.fullName);
            },
        );
      },
      routes: {
        "home": (context) => Home(),
        "list_user": (context) => ListUserScreen(),
        "add_user": (context) => AddUserScreen(),
        "user": (context) => UserScreen(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  late String idUser;
  late String fullName;

  MainScreen({Key? key, required this.idUser, required this.fullName }) : super(key: key);

  @override
  State<MainScreen> createState() => _UserState();
}

class _UserState extends State<MainScreen> {

  Map<String, dynamic> _user = {"id": null};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    HTTPNetwork.getUser(widget.idUser).then((value) {
      setState(() {
        _user = value[0];
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: BaseAppBar(titlePage: widget.fullName, context: context),
      body: isLoading 
        ? Center( child: Column(mainAxisAlignment: MainAxisAlignment.center ,children: const[
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text("Loading, wait...")
          ]),
        )
        : (_user["id"] == null ? 
          const Center(
            child: Text("This user don't exist"),
          )
         : Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  User.Picture(_user["picture"]),
                  const SizedBox(height: 20),
                  Title(
                    color:  Colors.black,
                    child: Text(
                      User.getFullName(_user),
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ),
                  const SizedBox(height: 10),
                  Text(_user["citation"].toString()),
                  const SizedBox(height: 5),
                  Card(child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const Icon(Icons.person),
                        const SizedBox(width: 5),
                        Text(_user["gender"].toString())
                      ],
                    ),
                  )),
                  Card(child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const Icon(Icons.phone),
                        const SizedBox(width: 5),
                        Text(_user["phone"].toString())
                      ],
                    ),
                  )),
                  Card(child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const Icon(Icons.location_city),
                        const SizedBox(width: 5),
                        Text(_user["adress"].toString())
                      ],
                    ),
                  )),
                ],
              )
            ),
          ),
        )),
    );
  }
}