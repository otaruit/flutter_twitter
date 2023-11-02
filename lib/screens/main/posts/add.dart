import 'package:flutter/material.dart';
import 'package:flutter_twitter/services/posts.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final PostService _postService = PostService();
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Tweet'),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () async {
              _postService.savePost(text);
              Navigator.pop(context);
            }, // ボタンが無効な状態
            child: const Text(
              'Tweet',
              style: TextStyle(
                color: Colors.white, // テキストの色
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Form(child: TextField(
          onChanged: (val) {
            setState(() {
              text = val;
            });
          },
        )),
      ),
    );
  }
}
