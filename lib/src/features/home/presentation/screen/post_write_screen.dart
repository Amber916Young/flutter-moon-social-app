import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moon/src/core/component/portal_master_layout.dart';

class PostWriteScreen extends StatefulWidget {
  const PostWriteScreen({Key? key}) : super(key: key);

  @override
  State<PostWriteScreen> createState() => _PostWriteScreenState();
}

class _PostWriteScreenState extends State<PostWriteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController tagsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PortalMasterLayout(
        pageIndex: 0,
        showDrawer: true,
        endDrawerEnableOpenDragGesture: true,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: tagsController,
                  decoration: InputDecoration(
                    labelText: 'Tags',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Add functionality to submit the post
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ));
  }
}
