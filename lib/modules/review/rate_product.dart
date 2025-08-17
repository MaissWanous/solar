import 'package:flutter/material.dart';

class RateProduct extends StatefulWidget {
  final int initialRating;
  RateProduct({required this.initialRating});

  @override
  _RateProductState createState() => _RateProductState();
}

class _RateProductState extends State<RateProduct> {
  int rating = 0;
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    rating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rate Product")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage("https://via.placeholder.com/150"),
            ),
            SizedBox(height: 8),
            Text("Soso Alkusaiar", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    Icons.star,
                    color: index < rating ? Colors.amber : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      rating = index + 1;
                    });
                  },
                );
              }),
            ),
            TextField(
              controller: commentController,
              decoration: InputDecoration(
                hintText: "Describe the product...",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}
