
import 'package:flutter/material.dart';

class CategoryText extends StatelessWidget {
  //const CategoryText({super.key});

  final List<String> _categorylabel = ['Vegetables','Fruits','Grains','Fresh Milk','Green Leaves'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categories',
            style: TextStyle(
              fontSize: 20,
            ),
          ),

          Container(
            height: 50,
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categorylabel.length,
                  itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ActionChip(
                      backgroundColor: Color.fromARGB(255, 169, 244, 83),
                      onPressed: () {},
                      label: Center(
                        child: Text(
                          _categorylabel[index],
                                           style: TextStyle(
                                            color: const Color.fromARGB(255, 8, 135, 239),
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),),
                      )),
                  );
                
                  },
                  ),
                ),

                IconButton(
                  onPressed: (){},
              
               icon: Icon(Icons.arrow_forward_ios),
               ),
              ],
            ),
          )
        ],
      ),
    );
  }
}