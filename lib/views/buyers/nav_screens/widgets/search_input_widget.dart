import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchInputWidget extends StatelessWidget {
  const SearchInputWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: ClipRRect(     
        
          borderRadius: BorderRadius.circular(10),
          child: TextField(
            decoration: InputDecoration(
              fillColor: const Color.fromARGB(255, 245, 236, 161)   ,        filled: true,
              hintText: 'Search For Products',
              border: OutlineInputBorder(
                borderSide: BorderSide.none
              ),
              prefixIcon: Icon(CupertinoIcons.search),
              ),
            ),
         
      ),
    );
  }
}

