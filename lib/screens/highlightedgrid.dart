import 'package:flutter/material.dart';
import 'package:mobigic/screens/gridsize.dart';

class HighlightedGridScreen extends StatelessWidget {
  final List<List<String>> grid;
  final List<List<bool>> highlightGrid;

  const HighlightedGridScreen(
      {super.key, required this.grid, required this.highlightGrid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Highlighted Grid',
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
              child: buildHighlightedGrid(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Reset the setup and navigate back to the splash screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EnterGridSizeScreen()),
                );
              },
              child: const Text('Reset Setup'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHighlightedGrid() {
    List<Widget> rows = [];
    for (int i = 0; i < grid.length; i++) {
      List<Widget> rowWidgets = [];
      for (int j = 0; j < grid[i].length; j++) {
        rowWidgets.add(
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: highlightGrid[i][j] ? Colors.yellow : null,
            ),
            child: Center(
              child: Text(
                grid[i][j],
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
