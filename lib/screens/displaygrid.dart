import 'package:flutter/material.dart';
import 'package:mobigic/screens/searchalphabet.dart';

class GridDisplayScreen extends StatefulWidget {
  final List<List<String>> grid;

  const GridDisplayScreen({super.key, required this.grid});

  @override
  State<GridDisplayScreen> createState() => _GridDisplayScreenState();
}

class _GridDisplayScreenState extends State<GridDisplayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Display Grid',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 35.0, right: 35),
              child: buildGridDisplay(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the text search screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TextSearchScreen(grid: widget.grid),
                  ),
                );
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGridDisplay() {
    List<Widget> rows = [];
    for (int i = 0; i < widget.grid.length; i++) {
      List<Widget> rowWidgets = [];
      for (int j = 0; j < widget.grid[i].length; j++) {
        rowWidgets.add(
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: Center(
              child: Text(
                widget.grid[i][j],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      }
      rows.add(Row(children: rowWidgets));
    }
    return Column(children: rows);
  }
}
