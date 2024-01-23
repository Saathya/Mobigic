import 'package:flutter/material.dart';
import 'package:mobigic/screens/highlightedgrid.dart';

class TextSearchScreen extends StatefulWidget {
  final List<List<String>> grid;

  const TextSearchScreen({super.key, required this.grid});

  @override
  State<TextSearchScreen> createState() => _TextSearchScreenState();
}

class _TextSearchScreenState extends State<TextSearchScreen> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Search Alphabet',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 150,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white, // Set the background color to white
              borderRadius: BorderRadius.circular(
                  12.0), // Optional: Add border radius for a rounded appearance
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 20, 10, 18),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchText = value;
                      });
                    },
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter Your Alphabet (East, South, East-South)',
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Perform text search and highlight
                    List<List<bool>> highlightGrid =
                        searchAndHighlight(searchText);
                    // Navigate to the next screen to display the highlighted grid
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HighlightedGridScreen(
                          grid: widget.grid,
                          highlightGrid: highlightGrid,
                        ),
                      ),
                    );
                  },
                  child: const Text('Search Text'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<List<bool>> searchAndHighlight(String searchText) {
    List<List<bool>> result = List.generate(widget.grid.length,
        (i) => List.generate(widget.grid[i].length, (j) => false));

    // Search left to right
    for (int i = 0; i < widget.grid.length; i++) {
      for (int j = 0; j <= widget.grid[i].length - searchText.length; j++) {
        bool found = true;
        for (int k = 0; k < searchText.length; k++) {
          if (widget.grid[i][j + k] != searchText[k]) {
            found = false;
            break;
          }
        }
        if (found) {
          for (int k = 0; k < searchText.length; k++) {
            result[i][j + k] = true;
          }
        }
      }
    }

    // Search top to bottom
    for (int j = 0; j < widget.grid[0].length; j++) {
      for (int i = 0; i <= widget.grid.length - searchText.length; i++) {
        bool found = true;
        for (int k = 0; k < searchText.length; k++) {
          if (widget.grid[i + k][j] != searchText[k]) {
            found = false;
            break;
          }
        }
        if (found) {
          for (int k = 0; k < searchText.length; k++) {
            result[i + k][j] = true;
          }
        }
      }
    }

    // Search diagonal (south-east)
    for (int i = 0; i <= widget.grid.length - searchText.length; i++) {
      for (int j = 0; j <= widget.grid[i].length - searchText.length; j++) {
        bool found = true;
        for (int k = 0; k < searchText.length; k++) {
          if (widget.grid[i + k][j + k] != searchText[k]) {
            found = false;
            break;
          }
        }
        if (found) {
          for (int k = 0; k < searchText.length; k++) {
            result[i + k][j + k] = true;
          }
        }
      }
    }

    return result;
  }
}
