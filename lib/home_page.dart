import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _loadSavedText();
  }

  _loadSavedText() async {
    _prefs = await SharedPreferences.getInstance();
    String savedText1 = _prefs.getString('savedText1') ?? '';
    String savedText2 = _prefs.getString('savedText2') ?? '';
    setState(() {
      _titleController.text = savedText1;
      _contentController.text = savedText2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              color: Colors.grey,
              child: ListTile(
                title: TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.text_fields),
                    labelText: 'Enter title',
                  ),
                ),
                subtitle: TextField(
                  controller: _contentController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.text_fields),
                    labelText: 'Enter content',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                String textToSave1 = _titleController.text;
                String textToSave2 = _contentController.text;

                await _prefs.setString(
                  textToSave1,
                  textToSave2,
                );

                // ignore: use_build_context_synchronously
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SecondPage()),
                );
              },
              child: const Text('Save Note'),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Saved Note:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            FutureBuilder<String>(
              future: _loadSavedText(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.grey,
                      width: double.infinity,
                      height: 300,
                      child: ListTile(
                        title: Text(
                          snapshot.data ?? 'No saved Note',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _loadSavedText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('savedNote') ?? '';
  }
}
