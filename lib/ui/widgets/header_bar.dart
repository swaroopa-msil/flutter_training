import 'package:flutter/material.dart';

class HeaderBar extends StatelessWidget {
  const HeaderBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 40,
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: SizedBox(
                  height: 40,
                  width: 70,
                  child: Center(
                    child: Text(
                      'CALL',
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),
                    ),
                  )
              )),
          Expanded(
              flex: 2,
              child: SizedBox(
                  height: 40,
                  width: 70,
                  child: Center(
                    child: Text(
                      'Strike Price',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
              )),
          Expanded(
              flex: 3,
              child: SizedBox(
                  height: 40,
                  width: 70,
                  child: Center(
                    child: Text(
                      'PUT',
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),
                    ),
                  )
              ))
        ],
      ),
    );
  }
}
