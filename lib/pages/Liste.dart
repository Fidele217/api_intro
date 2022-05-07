import 'package:flutter/material.dart';
import '../Https/network.dart';
import '../Classes/Arguments/UserArguments.dart';
import '../Classes/User.dart';
import '../components/appbar.dart';

class ListUserScreen extends StatefulWidget {
  ListUserScreen({Key? key}) : super(key: key);

  @override
  State<ListUserScreen> createState() => _ListUserScreenState();
}

class _ListUserScreenState extends State<ListUserScreen> {

  List<Map<String, dynamic>> _listUser = [];
  late SearchDelegate<String> _delegate;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    
    HTTPNetwork.getUsers().then((value) {
      setState(() {
        _listUser = value;
        isLoading = false;
      });
    });
  }

  Widget _buildRow(var user) {
    return Card(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            "user",
            arguments: UserArguments(user["id"], User.getFullName(user))
          );
        },
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: User.Leading(user["picture"]),
          ),
          title: Text(User.getFullName(user)),
          subtitle: Text(user["phone"]),
        ),
      )
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(titlePage: "Liste", context: context),
      body: isLoading ? 
        Center( child: Column(mainAxisAlignment: MainAxisAlignment.center ,children: const[
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text("Loading, wait...")
          ]),
        )
        : Container(
          padding: const EdgeInsets.only(
            top: 16.0
          ),
          child: SingleChildScrollView(child: Column(
            children: [
              Title(
                color: Colors.black,
                child: const Text(
                  "Liste des utilisateurs",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                  ),
                )
              ),
              _listUser.isEmpty 
              ? Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.all(8.0),
                child: const Text("No user for a moment."),
              )
              : ListView.builder(
                itemCount: _listUser.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(16.0),
                itemBuilder: (context, index) {
                  var user = _listUser[index];
                  return _buildRow(user);
                }
              )
            ],
          )),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {
          Navigator.of(context).pushNamed("add_user");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}