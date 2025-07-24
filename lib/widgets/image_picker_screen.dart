import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

const String captureImage = "Capture Image";

const String pickFromFiles = "Pick from Files";

const String selectFile = "Select PDF/Image File";

const String confirmSelection = "Confirm Selection";

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key, required this.selectedFiles});
  final List<Map<String, dynamic>> selectedFiles;
  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  late List<Map<String, dynamic>> _selectedFiles;

  @override
  void initState() {
    super.initState();
    _selectedFiles = widget.selectedFiles;
  }

  _selectFile() {
    _showFileSourceOptions().then((pickedFile) async {
      if (pickedFile != null) {
        setState(() {
          _selectedFiles.add({
            "file": File(pickedFile.path),
          });
        });
      }
    });
  }

  Future<File?> _showFileSourceOptions() async {
    File? selectedFile;

    await showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text(captureImage),
              onTap: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image =
                    await picker.pickImage(source: ImageSource.camera);
                if (image != null) {
                  selectedFile = File(image.path);
                }
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.folder),
              title: const Text(pickFromFiles),
              onTap: () async {
                final result = await FilePicker.platform.pickFiles(
                  allowMultiple: false,
                  dialogTitle: selectFile,
                  type: FileType.custom,
                  allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
                );
                if (result != null && result.files.single.path != null) {
                  selectedFile = File(result.files.single.path!);
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );

    return selectedFile;
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context, _selectedFiles);
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text(selectFile),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              child: InkWell(
                onTap: _selectFile,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "selectedFiles: ${_selectedFiles.length}",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: _selectFile,
                      icon: Icon(
                        Icons.attach_file,
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: _selectedFiles.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      _selectedFiles[index]['file'].path.endsWith('.jpg') ||
                              _selectedFiles[index]['file']
                                  .path
                                  .endsWith('.jpeg') ||
                              _selectedFiles[index]['file']
                                  .path
                                  .endsWith('.png')
                          ? Image.file(
                              File(_selectedFiles[index]['file'].path),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            )
                          : Container(
                              color: Colors.grey[300],
                              child: Center(
                                child: Icon(
                                  Icons.insert_drive_file,
                                  size: 40.sp,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedFiles.removeAt(index);
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: colorScheme.errorContainer,
                              shape: BoxShape.circle,
                            ),
                            padding: EdgeInsets.all(4.w),
                            child: Icon(
                              Icons.close,
                              color: colorScheme.onErrorContainer,
                              size: 16.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _selectedFiles);
              },
              child: const Text(confirmSelection),
            ),
          ],
        ),
      ),
    );
  }
}
