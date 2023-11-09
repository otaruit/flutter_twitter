import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_twitter/models/post.dart';
import 'package:flutter_twitter/models/user.dart';
import 'package:flutter_twitter/screens/main/posts/list.dart';
import 'package:flutter_twitter/services/posts.dart';
import 'package:flutter_twitter/services/user.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  PostService _postService = PostService();
  UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<PostModel>>.value(
          value: _postService.getPostsByUser(
              FirebaseAuth.instance.currentUser?.uid,
              initialData: null),
          initialData: const [],
        ),
        StreamProvider.value(
          value: _userService.getUserInfo(
              FirebaseAuth.instance.currentUser?.uid,
              initialData: null),
          initialData: const [],
        ),
      ],
      child: Scaffold(
          // body: Text(Provider.of<UserModel>(context).profileImageUrl),
          body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, _) {
            return [
        
              SliverAppBar(
                floating: false,
                pinned: true,
                expandedHeight: 130,
                flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                  Provider.of<UserModel>(context).bannerImageUrl ?? '',
                  fit: BoxFit.fitWidth,
                )),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.network(
                          Provider.of<UserModel>(context).profileImageUrl ?? '',
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/edit');
                            },
                            child: Text('Edit Profile'))
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          Provider.of<UserModel>(context).name ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    )
                  ]),
                )
              ]))
            ];
          },
          body: ListPosts(),
        ),
      )),
    );
  }
}
