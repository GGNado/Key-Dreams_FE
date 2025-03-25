import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileContent extends StatefulWidget {
  const UserProfileContent({super.key});

  @override
  State<UserProfileContent> createState() => _UserProfileContentState();
}

class _UserProfileContentState extends State<UserProfileContent> {
  String? username;
  String? nome;
  String? cognome;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('user_data');
    if (jsonString != null) {
      final userMap = jsonDecode(jsonString);
      setState(() {
        username = userMap['username'];
        nome = userMap['nome'];
        cognome = userMap['cognome'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://media.istockphoto.com/id/464988959/it/foto/germano-reale-con-clipping-path.jpg?s=612x612&w=0&k=20&c=I5PX4rXbcqMSUCY_OFktsE-CcqI51_jhuJw1Bt0hxKE='),
            ),
            const SizedBox(height: 16),
            Text(
              nome != null && cognome != null ? '$nome $cognome' : 'Caricamento...',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              username ?? '',
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}