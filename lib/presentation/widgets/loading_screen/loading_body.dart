
import 'package:flutter/material.dart';

class LoadingBody extends StatelessWidget {
  const LoadingBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(), // Loading indicator
          SizedBox(height: 16.0),
          Text('Loading...'), // Optional loading text
        ],
      ),
    );
  }
}
