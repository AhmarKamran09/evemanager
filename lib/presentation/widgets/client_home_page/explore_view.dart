import 'package:flutter/material.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: TextButton(
            onPressed: () {},
            child: Text('data'),
          ),
        ),
        Expanded(
          child: Container(
            child: ListView(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
// create a listbuilder showing images such that if index
//is odd size is small else large just like insta search page
                          Text('data'),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
// create a listbuilder showing images such that if index
//is even size is small else large just like insta search page
                          Text('data'),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
