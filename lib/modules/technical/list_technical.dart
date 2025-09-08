import 'package:flutter/material.dart';
import 'package:udemy_flutter/controllers/list_technical_controller.dart';
import 'package:udemy_flutter/models/list_technical_model.dart';
import 'package:udemy_flutter/modules/technical/profile_technical.dart';

const Color yellow = Color(0xFFFFBF00);

class List_Technical extends StatefulWidget {
  const List_Technical({Key? key}) : super(key: key);

  @override
  State<List_Technical> createState() => _ListTechnicalState();
}

class _ListTechnicalState extends State<List_Technical> {
  final TechnicalController _controller = TechnicalController();

  late Future<List<TechnicalUser>> _futureUsers;

  @override
  void initState() {
    super.initState();
    _futureUsers = _controller.getTechnicalUsers();
  }

  Widget buildTechnicalItem(BuildContext context, TechnicalUser user) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Profile_Technical(
              fullName: user.fullName,
              phone: user.phone ?? 'غير متوفر',
              country: user.country,
              profilePic: user.imagePath,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: yellow),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20.0,
                backgroundImage: AssetImage(user.imagePath),
                backgroundColor: Colors.grey[200],
              ),
              const SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.fullName,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14.0),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    user.country,
                    style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14.0),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder<List<TechnicalUser>>(
          future: _futureUsers,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No technical profiles found.'));
            } else {
              final users = snapshot.data!;
              return ListView.separated(
                itemCount: users.length,
                itemBuilder: (context, index) => buildTechnicalItem(context, users[index]),
                separatorBuilder: (context, index) => const SizedBox(height: 10.0),
              );
            }
          },
        ),
      ),
    );
  }
}
