import 'package:flutter/material.dart';
import 'package:slidable/slidable.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slidable Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Slidable Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static String exTitle = "Example title long text example text test";
  static String body =
      "Lorem ipsum dolor sit amet, consectetur adipisc ing elit, sed do eiusmod tempor incididunt uteore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit ess bgh mdolore eu fugiat nulla pariatur. Exeftj integhre ecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum";
  int? idAction;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: List.generate(5, (index) {
          return Slidable(
            id: index,
            widthEndAction: 74,
            onChangeAction: onChangeAction,
            onPressedAction: onPressedAction,
            isAction: (idAction != null) ?  index == idAction:false,
            endAction: const [
              DeleteAction(),
            ],
            child: ContentItem(
              title: exTitle,
              subtitle: body,
            ),
          );
        }),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


  void onChangeAction(int? id){
    idAction = id;
    updateScreen();
  }

  void onPressedAction(int? id){
    print('Delete index $id');
    idAction = null;
    updateScreen();
  }

  void updateScreen() {
    if (mounted) {
      setState(() {});
    }
  }

}

class ContentItem extends StatelessWidget {
  const ContentItem({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        print('Click Me!!');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ListTile(
          leading: ClipOval(
            child: Container(
              width: 40,
              height: 40,
              color: Colors.green,
              child: const Icon(
                Icons.account_balance_wallet,
                color: Colors.white,
              ),
            ),
          ),
          title: Text(
            title,
            maxLines: 1,
          ),
          subtitle: Text(
            subtitle,
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}

class DeleteAction extends StatelessWidget {
  const DeleteAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 74,
      height: 70,
      color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
          Text(
            'Delete',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
