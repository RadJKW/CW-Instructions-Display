// ignore_for_file: avoid_print

import 'package:fluent_ui/fluent_ui.dart';
import 'dart:io';

class FileBrowse extends StatefulWidget {
  const FileBrowse({Key? key}) : super(key: key);

  @override
  State<FileBrowse> createState() => _FileBrowseState();
}

class _FileBrowseState extends State<FileBrowse> {
  final String _path =
      '/mnt/public/CoilWinder_InstructionsDisplay/WindingPractices/Documents/Updated/';
  // final String _pathD2 =
  //     '/mnt/public/CoilWinder_InstructionsDisplay/WindingPractices/Documents/Updated/D2 Pad';
  // final String _pathD3 =
  //     '/mnt/public/CoilWinder_InstructionsDisplay/WindingPractices/Documents/Updated/D3 3PH';
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: const PageHeader(title: Text('Network File Browser')),
      children: <Widget>[
        // use a FutureBuilder to display the contents of the directory
        // this widget should use the helper function _buildCopilotDirectoryTree

        FutureBuilder<TreeViewItem>(
            future: _buildDirectoryTree(_path),
            builder:
                (BuildContext context, AsyncSnapshot<TreeViewItem> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: Text("Loading"));
              } else {
                return TreeView(items: snapshot.data!.children);
              }
            })

        // FutureBuilder<TreeViewItem>(
        //     future: _buildDirectoryTree(_path),
        //     builder: (context, snapshot) {
        //       if (!snapshot.hasData) {
        //         return const Center(child: Text("Loading"));
        //       } else {
        //         return TreeView(items: snapshot.data!.children);
        //       }
        //     })
      ],
    );
  }

  // Future<TreeViewItem> _buildFirstChildrenTree (String path) async {
  // this should return (n) number of treeViewItems depending on how many children are under the parent path
  // Each child should repeat the same process as the parent until it reaches the final child that has files
  // the text of each child's TreeViewItem should be the name of the directory and not contain the parent path

  Future<TreeViewItem> _buildCopilotDirectoryTree(String path) async {
    final Directory directory = Directory(path);
    final List<FileSystemEntity> children = directory.listSync(recursive: true);
    final List<TreeViewItem> items = <TreeViewItem>[];
    for (final FileSystemEntity child in children) {
      if (child is Directory) {
        final String name = child.path.substring(path.length + 1);
        items.add(TreeViewItem(
          key: ValueKey(name),
          content: Text(name),
          value: name, 
          children: <TreeViewItem>[],
        ));
      }
    }
    return TreeViewItem(
      key: ValueKey(path),
      content: Text(path),
      value: path,
      children: items,
    );
  }

  // build the directory tree
  Future<TreeViewItem> _buildDirectoryTree(String path) async {
    // path to directory
    var dir = Directory(path);
    // list of children
    var children = <TreeViewItem>[];
    // iterate over directory
    await for (var entity in dir.list(recursive: false)) {
      // if entity is a directory
      if (entity is Directory) {
        // recurse
        children.add(await _buildDirectoryTree(entity.path));
      }
    }
    return TreeViewItem(
        content: Text(
          dir.path,
        ),
        value: dir.path,
        children: children);
  }
}
