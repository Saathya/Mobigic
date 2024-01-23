import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobigic/screens/displaygrid.dart';

class EnterAlphabetsScreen extends StatefulWidget {
  final int m;
  final int n;

  const EnterAlphabetsScreen({super.key, required this.m, required this.n});

  @override
  State<EnterAlphabetsScreen> createState() => _EnterAlphabetsScreenState();
}

class _EnterAlphabetsScreenState extends State<EnterAlphabetsScreen> {
  List<List<String>> grid =
      List.generate(0, (i) => List.generate(0, (j) => ''));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Enter Alphabets',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildGridInput(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the grid display screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GridDisplayScreen(grid: grid),
                    ),
                  );
                },
                child: const Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGridInput() {
    List<Widget> columns = [];

    for (int i = 0; i < widget.m; i++) {
      List<Widget> columnWidgets = [];

      for (int j = 0; j < widget.n; j += 2) {
        List<Widget> rowWidgets = [];

        // Add the first TextField in the row
        rowWidgets.add(
          SizedBox(
            width: 80,
            child: TextField(
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(
                    1), // Limit the length to 1 alphabet
              ],
              onChanged: (value) {
                setState(() {
                  if (grid.length <= i) {
                    grid.add(List.generate(widget.n, (index) => ''));
                  }
                  grid[i][j] = value;
                });
              },
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintText: 'Only One',
                hintStyle: const TextStyle(
                  fontSize: 12,
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
        );

        // Check if there is another column available
        if (j + 1 < widget.n) {
          // Add the second TextField in the row
          rowWidgets.add(
            SizedBox(
              width: 80,
              child: TextField(
                textAlign: TextAlign.center,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(
                      1), // Limit the length to 10 digits
                ],
                onChanged: (value) {
                  setState(() {
                    if (grid.length <= i) {
                      grid.add(List.generate(widget.n, (index) => ''));
                    }
                    grid[i][j + 1] = value;
                  });
                },
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: 'Only One',
                  hintStyle: const TextStyle(
                    fontSize: 12,
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
          );
        }

        // Add the row to the column
        columnWidgets.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: rowWidgets,
          ),
        );
      }

      // Add the column to the columns list
      columns.add(
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: columnWidgets,
        ),
      );
    }

    // Return the final column containing all the rows
    return Column(
      children: columns,
    );
  }
}
