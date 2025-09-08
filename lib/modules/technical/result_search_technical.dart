import 'package:flutter/material.dart';
import 'package:udemy_flutter/controllers/list_technical_controller.dart';
import 'package:udemy_flutter/models/list_technical_model.dart';
import 'package:udemy_flutter/modules/technical/profile_technical.dart';

class ResultSearchTechnical extends StatefulWidget {
  final String searchQuery;

  ResultSearchTechnical({Key? key, required this.searchQuery}) : super(key: key);

  @override
  State<ResultSearchTechnical> createState() => _ResultSearchTechnicalState();
}

class _ResultSearchTechnicalState extends State<ResultSearchTechnical> {
  final TechnicalController _controller = TechnicalController();
  late Future<List<TechnicalUser>> _futureUsers;
  final Color yellow = const Color(0xFFFFBF00);

  @override
  void initState() {
    super.initState();
    // جلب كل المستخدمين ثم فلترتهم بناءً على النص المدخل
    _futureUsers = _controller.getTechnicalUsers().then((list) {
      return list.where((user) =>
          user.fullName.toLowerCase().contains(widget.searchQuery.toLowerCase())).toList();
    });
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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Profile_Technical(
                        fullName: user.fullName,
                        phone: user.phone ?? 'Nout found ',
                        country: user.country,
                        profilePic: user.imagePath,
                      ),
                    ),
                  );
                },
                child: CircleAvatar(
                  radius: 20.0,
                  backgroundImage: AssetImage(user.imagePath),
                  backgroundColor: Colors.grey[200],
                ),
              ),
              const SizedBox(width: 10.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Profile_Technical(
                        fullName: user.fullName,
                        phone: user.phone ?? 'Nout found',
                        country: user.country,
                        profilePic: user.imagePath,
                      ),
                    ),
                  );
                },
                child: Column(
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        foregroundColor: Colors.black,
      ),
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
              final filteredUsers = snapshot.data!;
              return ListView.separated(
                itemCount: filteredUsers.length,
                itemBuilder: (context, index) => buildTechnicalItem(context, filteredUsers[index]),
                separatorBuilder: (context, index) => const SizedBox(height: 10.0),
              );
            }
          },
        ),
      ),
    );
  }
}
