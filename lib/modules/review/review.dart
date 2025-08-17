import 'package:flutter/material.dart';
import 'package:udemy_flutter/modules/review/rate_product.dart';

class Reviews extends StatelessWidget {
  final List<Map<String, dynamic>> reviews = List.generate(10, (index) {
    return {
      "name": "User ${index + 1}",
      "time": "${index + 1}h ago",
      "rating": (index % 5) + 1,
      "comment": "This product is very good ${index + 1}.",
      "profile": "https://via.placeholder.com/150"
    };
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reviews")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(review["profile"]),
                  ),
                  title: Row(
                    children: [
                      Text(review["name"], style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(width: 8),
                      Text(review["time"], style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: List.generate(5, (starIndex) {
                          return Icon(
                            Icons.star,
                            color: starIndex < review["rating"] ? Colors.amber : Colors.grey,
                            size: 20,
                          );
                        }),
                      ),
                      SizedBox(height: 4),
                      Text(review["comment"]),
                    ],
                  ),
                );
              },
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text("Rate this product", style: TextStyle(fontSize: 16)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return IconButton(
                      icon: Icon(Icons.star, color: Colors.grey),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RateProduct(initialRating: index + 1),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
