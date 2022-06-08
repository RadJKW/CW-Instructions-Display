// ignore_for_file: avoid_print

import 'package:fluent_ui/fluent_ui.dart';
import 'dart:io';
import 'package:darq/darq.dart';

class FileBrowse extends StatefulWidget {
  const FileBrowse({Key? key}) : super(key: key);

  @override
  State<FileBrowse> createState() => _FileBrowseState();
}

class _FileBrowseState extends State<FileBrowse> {
  // if _path
  String get _currentViewPath => _path.replaceAll(_basePath, '');
  String _path =
      '/mnt/public/CoilWinder_InstructionsDisplay/WindingPractices/Documents/Updated/';

  final String _basePath =
      '/mnt/public/CoilWinder_InstructionsDisplay/WindingPractices/Documents/Updated/';
  late var _items = [];

  bool atBasePath() => _path == _basePath;

  @override
  void initState() {
    super.initState();
    _getItemsFromPath(_path);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final padding = PageHeader.horizontalPadding(context);
    return ScaffoldPage(
        header: PageHeader(
          title: Text('NFS: $_currentViewPath',
              maxLines: 1, overflow: TextOverflow.ellipsis),
          commandBar: Expanded(
            child: AutoSuggestBox(
              placeholder: 'Directory List',
              items: _items
                  .orderBy((item) => item.path)
                  .map((item) =>
                      item.path.toString().substring(_basePath.length))
                  .toList(),
              leadingIcon: // if boolean atBasePath is true
                  // display the IconButton
                  // if false, display nothing
                  atBasePath()
                      ? null
                      : IconButton(
                          icon: const Icon(FluentIcons.chrome_back, size: 20),
                          onPressed: () {
                            setState(() {
                               _path = _basePath;
                            _getItemsFromPath(_path);
                            });
                           
                          }),
              onSelected: //set the state with the slected item
                  (item) {
                _path = _basePath + item;
                _getItemsFromPath(_path);
              },
            ),
          ),
        ),
        content: GridView.extent(
            maxCrossAxisExtent: 150,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            padding: EdgeInsets.only(
                top: kPageDefaultVerticalPadding,
                right: padding,
                left: padding),
            children: _items //.map((item) => Text(item.path)).toList()
                .map((item) => _buildHoverButton(context, item))
                .toList()));
  }

  void _getItemsFromPath(String path) {
    Iterable<FileSystemEntity> items = Directory(
      path,
    ).listSync();
    items = items.orderBy((item) => item.path);
    _items = items.toList();
  }

  void _setDirectoryState(item) {
    setState(() {
      _path = item.path;
      _getItemsFromPath(_path);
    });
  }

  void _goToParentDirectory() {
    print(_path.substring(0, _path.lastIndexOf('/')));
    setState(() {
      _path = _path.substring(0, _path.lastIndexOf('/'));
      _getItemsFromPath(_path);
    });
  }

  void setFileState(item) {
    // TODO: implement setFileState
  }

  Widget _buildHoverButton(BuildContext context, item) {
    {
      return HoverButton(
        onPressed: item is Directory
            ? () => _setDirectoryState(item)
            : () => setFileState(item),
        cursor: SystemMouseCursors.click,
        builder: (context, states) {
          return FocusBorder(
            focused: states.isFocused,
            child: Tooltip(
              useMousePosition: false,
              message:
                  // if the item is a directory: 'View Directory ${item.path.split('/').last}',
                  // if the item is a file: 'View File ${item.path.split('/').last}',
                  item is Directory
                      ? 'View Directory ${item.path.split('/').last}'
                      : 'View File ${item.path.split('/').last}',
              child: RepaintBoundary(
                child: AnimatedContainer(
                  duration: FluentTheme.of(context).fasterAnimationDuration,
                  decoration: BoxDecoration(
                    color: ButtonThemeData.uncheckedInputColor(
                      FluentTheme.of(context),
                      states,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        item is Directory
                            ? FluentIcons.folder_open
                            : FluentIcons.pdf,
                        size: 40,
                        color: states.isFocused
                            ? FluentTheme.of(context).activeColor
                            : FluentTheme.of(context).accentColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(
                          item.path.split('/').last,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    }
  }
}

// Working Hover Button 
// HoverButton(
//       key: ValueKey(item.path),
//       builder: (context, hovering) {
//         return Text(item.path.split('/').last);
//       },
//       onPressed: () {
//         if (item is Directory) {
//           setState(() {
//             _path = item.path;
//             _getItemsFromPath(_path);
//           });
//         } else if (item is File) {
//           // set the path to the file so that when the PdfViewer is opened, it will open to the file
//           // Navigator.pushNamed(context, '/file', arguments: item.path);
//         }
//       },
//     ))

// John Tree view implementation----------------------------------------------------
// build the directory tree
// Future<TreeViewItem> _buildDirectoryTree(String path) async {
//   // path to directory
//   var dir = Directory(path);
//   // list of children
//   var children = <TreeViewItem>[];
//   // iterate over directory
//   await for (var entity in dir.list(recursive: false)) {
//     // if entity is a directory
//     if (entity is Directory) {
//       children.add(await _buildDirectoryTree(entity.path));
//     }
//   }
//   var text = dir.path.split('/').last;
//   return TreeViewItem(
//       expanded: false,
//       content: () {
//         print(text);
//         return Text(text);
//       }(),
//       value: text,
//       children: children);
// }
// FutureBuilder<TreeViewItem>(
//             future: _buildDirectoryTree(_path),
//             builder:
//                 (BuildContext context, AsyncSnapshot<TreeViewItem> snapshot) {
//               if (!snapshot.hasData) {
//                 return const Center(child: Text("Loading"));
//               } else {
//                 return TreeView(items: snapshot.data!.children);
//               }
//             }),
// FutureBuilder<TreeViewItem>(
//     future: _buildDirectoryTree(_path),
//     builder: (context, snapshot) {
//       if (!snapshot.hasData) {
//         return const Center(child: Text("Loading"));
//       } else {
//         return TreeView(items: snapshot.data!.children);
//       }
//     })
// Future<TreeViewItem> _buildFirstChildrenTree (String path) async {
// this should return (n) number of treeViewItems depending on how many children are under the parent path
// Each child should repeat the same process as the parent until it reaches the final child that has files
// the text of each child's TreeViewItem should be the name of the directory and not contain the parent path
// Future<TreeViewItem> _buildCopilotDirectoryTree(String path) async {
//   final Directory directory = Directory(path);
//   final List<FileSystemEntity> children = directory.listSync(recursive: true);
//   final List<TreeViewItem> items = <TreeViewItem>[];
//   for (final FileSystemEntity child in children) {
//     if (child is Directory) {
//       final String name = child.path.substring(path.length + 1);
//       items.add(TreeViewItem(
//         key: ValueKey(name),
//         content: Text(name),
//         value: name,
//         children: <TreeViewItem>[],
//       ));
//     }
//   }
//   return TreeViewItem(
//     key: ValueKey(path),
//     content: Text(path),
//     value: path,
//     children: items,
//   );
// }
// }  // end of John Tree View implementation
// --------------------------------------------------------------------------------

// copilot implementation ---------------------------------------------------------
//==========================================================================================
//final _fileController = TextEditingController();
// final _filePathController = TextEditingController();
// final _filePathFocusNode = FocusNode();
// final _fileList = <FileSystemEntity>[];
// final _directoryList = <FileSystemEntity>[];
// final _fileGridView = <Widget>[];
// FileSystemEntity? _selectedFile;
// FileSystemEntity? _selectedDirectory;
// String _basePath = '/';
// String _currentPath = '/';
// @override
// void initState() {
//   super.initState();
//   _filePathFocusNode.addListener(() {
//     if (_filePathFocusNode.hasFocus) {
//       _filePathController.selection = TextSelection(
//         baseOffset: 0,
//         extentOffset: _filePathController.text.length,
//       );
//     }
//   });
// }
// @override
// void dispose() {
//   _filePathFocusNode.dispose();
//   _filePathController.dispose();
//   _fileController.dispose();
//   super.dispose();
// }
// @override
// Widget build(BuildContext context) {
//   final appTheme = context.watch<AppTheme>();
//   final mqttAppState = context.watch<MqttState>();
//   final typography = FluentTheme.of(context).typography;
//   return Scaffold(
//     appBar: AppBar(
//       title: Text(
//         'File Browser',
//         style: typography.title?.apply(),
//       ),
//       actions: <Widget>[
//         IconButton(
//           icon: Icon(Icons.refresh),
//           onPressed: () {
//             _refreshFileList();
//           },
//         ),
//       ],
//     ),
//     body: Column(
//       children: <Widget>[
//         Row(
//           children: <Widget>[
//             Expanded(
//               child: TextField(
//                 controller: _filePathController,
//                 focusNode: _filePathFocusNode,
//                 decoration: InputDecoration(
//                   labelText: 'Path',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//             ),
//             IconButton(
//               icon: Icon(Icons.search),
//               onPressed: () {
//                 _filePathFocusNode.unfocus();
//                 _refreshFileList();
//               },
//             ),
//           ],
//         ),
//         Expanded(
//           child: GridView.count(
//             crossAxisCount: 3,
//             children: _fileGridView,
//           ),
//         ),
//         Row(
//           children: <Widget>[
//             Expanded(
//               child: TextField(
//                 controller: _fileController,
//                 decoration: InputDecoration(
//                   labelText: 'File',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//             ),
//             IconButton(
//               icon: Icon(Icons.search),
//               onPressed: () {
//                 _fileController.unfocus();
//                 _refreshFileList();
//               },
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }