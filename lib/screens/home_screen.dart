import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rnm_graphql/blocs/home/home_bloc.dart';
import 'package:rnm_graphql/blocs/home/home_states.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List data = [];

  @override
  void initState() {
    super.initState();
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('GraphQL Demo'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeStates>(
      builder: (BuildContext context, HomeStates state) {
        if (state is Loading) {
          return Scaffold(
            appBar: _buildAppBar(),
            body: LinearProgressIndicator(),
          );
        } else if (state is LoadDataFail) {
          return Scaffold(
            appBar: _buildAppBar(),
            body: Center(child: Text(state.error)),
          );
        } else {
          data = (state as LoadDataSuccess).data['empolyee'];

          return _buildBody();
        }
      },
    );
  }

  Widget _buildBody() {
    return Scaffold(
          body: ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          var item = data[index];
          print(data[0]['name']);
          return Card(
              elevation: 4.0,
              margin: EdgeInsets.all(8.0),
              child: ListTile(
                             
                              leading: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.blue[900],
                                child: Text(
                                 item['id']
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              title:
                                  Text(item['name']),
                              subtitle:
                                  Text(item['city']),
                            ),);
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
