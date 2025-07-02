import 'dart:io';
import 'package:flutter/material.dart';
import 'package:health_care_app/generated/l10n.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileImage extends StatefulWidget {
  final String firstName;
  final bool isEditable;

  const ProfileImage({
    Key? key,
    required this.firstName,
    this.isEditable = false,
  }) : super(key: key);

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  File? _imageFile;
  String? _emailKey;

  @override
  void initState() {
    super.initState();
    _loadEmailAndImage();
  }

  Future<void> _loadEmailAndImage() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('logged_in_email');

    if (email == null) return;

    _emailKey = 'profile_image_path$email';
    final path = prefs.getString(_emailKey!);
    if (path != null && path.isNotEmpty) {
      setState(() {
        _imageFile = File(path);
      });
    }
  }

  Future<void> _pickImage() async {
    if (_emailKey == null) return;

    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_emailKey!, picked.path);
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  Future<void> _removeImage() async {
    if (_emailKey == null) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_emailKey!);
    setState(() {
      _imageFile = null;
    });
  }

  void _showOptionsSheet() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        final hasImage = _imageFile != null;
        return SafeArea(
          child: Wrap(
            children: [
              if (hasImage)
                ListTile(
                  leading: const Icon(Icons.visibility),
                  title: Text(S.of(context).showImage),
                  onTap: () {
                    Navigator.of(ctx).pop();
                    _showFullImage();
                  },
                ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text(
                  hasImage
                      ? S.of(context).change
                      : S.of(context).chooseImageFromGallery,
                ),
                onTap: () {
                  Navigator.of(ctx).pop();
                  _pickImage();
                },
              ),
              if (hasImage)
                ListTile(
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title: Text(
                    S.of(context).deleteImage,
                    style: const TextStyle(color: Colors.red),
                  ),
                  onTap: () {
                    Navigator.of(ctx).pop();
                    _removeImage();
                  },
                ),
              ListTile(
                leading: const Icon(Icons.close),
                title: Text(S.of(context).cancel),
                onTap: () => Navigator.of(ctx).pop(),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showFullImage() {
    if (_imageFile == null) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          backgroundColor: Colors.black,
          body: Center(
            child: InteractiveViewer(
              child: Image.file(_imageFile!),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final firstLetter =
        widget.firstName.isNotEmpty ? widget.firstName[0].toUpperCase() : '?';

    return GestureDetector(
      onTap: () {
        if (!widget.isEditable) return;
        _showOptionsSheet();
      },
      child: ClipOval(
        child: Container(
          width: 70,
          height: 70,
          color: Colors.grey.shade300,
          child: _imageFile != null
              ? Image.file(
                  _imageFile!,
                  fit: BoxFit.cover,
                  width: 70,
                  height: 70,
                )
              : Center(
                  child: Text(
                    firstLetter,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
