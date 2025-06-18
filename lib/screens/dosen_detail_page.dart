import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/dosen_model.dart';

class DosenDetailPage extends StatefulWidget {
  final Dosen dosen;
  const DosenDetailPage({Key? key, required this.dosen}) : super(key: key);

  @override
  State<DosenDetailPage> createState() => _DosenDetailPageState();
}

class _DosenDetailPageState extends State<DosenDetailPage> {
  final ApiService _apiService = ApiService();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nipController;
  late TextEditingController _namaLengkapController;
  late TextEditingController _noTeleponController;
  late TextEditingController _emailController;
  late TextEditingController _alamatController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nipController = TextEditingController(text: widget.dosen.nip);
    _namaLengkapController = TextEditingController(text: widget.dosen.namaLengkap);
    _noTeleponController = TextEditingController(text: widget.dosen.noTelepon);
    _emailController = TextEditingController(text: widget.dosen.email);
    _alamatController = TextEditingController(text: widget.dosen.alamat);
  }

  Future<void> _updateDosen() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final updatedDosen = Dosen(
        no: widget.dosen.no, // Keep the original 'no' for update
        nip: _nipController.text,
        namaLengkap: _namaLengkapController.text,
        noTelepon: _noTeleponController.text,
        email: _emailController.text,
        alamat: _alamatController.text,
      );

      try {
        await _apiService.updateDosen(updatedDosen);
        if (mounted) {
          Navigator.pop(context, true); // Pop with true to indicate success
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Gagal memperbarui dosen: ${e.toString().split(':').last.trim()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  Future<void> _deleteDosen() async {
    // Show a confirmation dialog before deleting
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus dosen ${widget.dosen.namaLengkap}?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false), // Dismiss and return false
              child: const Text('Batal', style: TextStyle(color: Colors.blueAccent)),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(dialogContext).pop(true), // Dismiss and return true
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      setState(() {
        _isLoading = true;
      });
      try {
        if (widget.dosen.no != null) {
          await _apiService.deleteDosen(widget.dosen.no!);
          if (mounted) {
            Navigator.pop(context, false); // Pop with false to indicate deletion
          }
        } else {
          throw Exception('Dosen ID (no) is missing, cannot delete.');
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Gagal menghapus dosen: ${e.toString().split(':').last.trim()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  void dispose() {
    _nipController.dispose();
    _namaLengkapController.dispose();
    _noTeleponController.dispose();
    _emailController.dispose();
    _alamatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Dosen: ${widget.dosen.namaLengkap}',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 4,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextFormField(
                controller: _nipController,
                labelText: 'NIP',
                hintText: 'Masukkan NIP dosen',
                icon: Icons.badge,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'NIP tidak boleh kosong';
                  }
                  return null;
                },
              ),
              _buildTextFormField(
                controller: _namaLengkapController,
                labelText: 'Nama Lengkap',
                hintText: 'Masukkan nama lengkap dosen',
                icon: Icons.person,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama lengkap tidak boleh kosong';
                  }
                  return null;
                },
              ),
              _buildTextFormField(
                controller: _noTeleponController,
                labelText: 'No. Telepon',
                hintText: 'Masukkan nomor telepon',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor telepon tidak boleh kosong';
                  }
                  return null;
                },
              ),
              _buildTextFormField(
                controller: _emailController,
                labelText: 'Email',
                hintText: 'Masukkan email dosen',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email tidak boleh kosong';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Masukkan email yang valid';
                  }
                  return null;
                },
              ),
              _buildTextFormField(
                controller: _alamatController,
                labelText: 'Alamat',
                hintText: 'Masukkan alamat dosen',
                icon: Icons.home,
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Alamat tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _updateDosen,
                      icon: const Icon(Icons.update),
                      label: const Text('Perbarui'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _deleteDosen,
                      icon: const Icon(Icons.delete),
                      label: const Text('Hapus'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for consistent text form field styling (duplicated for self-contained file)
  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: Icon(icon, color: Colors.blueAccent),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.blueAccent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.blueAccent.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
          ),
          filled: true,
          fillColor: Colors.blueAccent.withOpacity(0.05),
        ),
        validator: validator,
      ),
    );
  }
}