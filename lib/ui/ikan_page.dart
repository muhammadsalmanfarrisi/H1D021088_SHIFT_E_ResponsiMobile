import 'package:flutter/material.dart';
import 'package:tokokita/bloc/logout_bloc.dart';
import 'package:tokokita/bloc/ikan_bloc.dart';
import 'package:tokokita/model/ikan.dart';
import 'package:tokokita/ui/login_page.dart';
import 'package:tokokita/ui/ikan_detail.dart';
import 'package:tokokita/ui/ikan_form.dart';

class IkanPage extends StatefulWidget {
  const IkanPage({Key? key}) : super(key: key);

  @override
  _IkanPageState createState() => _IkanPageState();
}

class _IkanPageState extends State<IkanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Ikan'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26.0),
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => IkanForm()));
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout().then((value) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                });
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<List>(
        future: IkanBloc.getIkans(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListIkan(
                  list: snapshot.data,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ListIkan extends StatelessWidget {
  final List? list;

  const ListIkan({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list!.length,
      itemBuilder: (context, i) {
        return ItemIkan(
          ikan: list![i],
        );
      },
    );
  }
}

// ... (previous code remains unchanged)

class ItemIkan extends StatelessWidget {
  final Ikan ikan;

  const ItemIkan({Key? key, required this.ikan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IkanDetail(
              ikan: ikan,
            ),
          ),
        );
      },
      child: Card(
        elevation: 4.0,
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              decoration: BoxDecoration(
                  border: Border(right: BorderSide(width: 1.0, color: Colors.white))),
              child: Icon(Icons.adjust, color: Colors.white),
            ),
            title: Text(
              ikan.namaIkan!,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            subtitle: Text(
              ikan.jenis!,
              style: TextStyle(color: Colors.white70),
            ),
            trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
          ),
        ),
      ),
    );
  }
}

