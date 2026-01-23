import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as p;

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
  bool _isCompressing = false;

  @override
  void initState() {
    super.initState();
    _selectedFiles = List.from(widget.selectedFiles);
  }

  /// Helper to compress images only. PDFs are returned as-is.
  Future<File?> _compressImage(File file) async {
    final filePath = file.absolute.path;
    final extension = p.extension(filePath).toLowerCase();

    // Only compress common image formats
    if (extension == '.jpg' || extension == '.jpeg' || extension == '.png') {
      final outPath = p.join(
        p.dirname(filePath),
        "compressed_${p.basename(filePath)}",
      );

      XFile? result = await FlutterImageCompress.compressAndGetFile(
        filePath,
        outPath,
        quality: 70,
        format: extension == '.png' ? CompressFormat.png : CompressFormat.jpeg,
      );

      return result != null ? File(result.path) : file;
    }

    return file;
  }

  _selectFile() async {
    final pickedFile = await _showFileSourceOptions();
    if (pickedFile != null) {
      setState(() => _isCompressing = true);

      File? finalFile = await _compressImage(pickedFile);

      setState(() {
        _selectedFiles.add({"file": finalFile});
        _isCompressing = false;
      });
    }
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
                if (image != null) selectedFile = File(image.path);
                if (mounted) Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.folder),
              title: const Text(pickFromFiles),
              onTap: () async {
                final result = await FilePicker.platform.pickFiles(
                  allowMultiple: false,
                  type: FileType.custom,
                  allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
                );
                if (result != null && result.files.single.path != null) {
                  selectedFile = File(result.files.single.path!);
                }
                if (mounted) Navigator.pop(context);
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
          onPressed: () => Navigator.pop(context, _selectedFiles),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(selectFile),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: _isCompressing ? null : _selectFile,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Files Selected: ${_selectedFiles.length}",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.attach_file, color: colorScheme.primary),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: _selectedFiles.length,
                    itemBuilder: (context, index) {
                      final file = _selectedFiles[index]['file'] as File;
                      bool isImage =
                          p.extension(file.path).toLowerCase() != '.pdf';

                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: isImage
                                ? Image.file(file,
                                    fit: BoxFit.cover,
                                    width: 100.w,
                                    height: 100.w)
                                : Container(
                                    color: Colors.grey[300],
                                    child: Center(
                                      child: Icon(Icons.picture_as_pdf,
                                          size: 30.sp, color: Colors.red),
                                    ),
                                  ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () => setState(
                                  () => _selectedFiles.removeAt(index)),
                              child: CircleAvatar(
                                radius: 10.r,
                                backgroundColor: colorScheme.error,
                                child: Icon(Icons.close,
                                    size: 12.sp, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, _selectedFiles),
                    child: const Text(confirmSelection),
                  ),
                ),
              ],
            ),
          ),
          if (_isCompressing)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
