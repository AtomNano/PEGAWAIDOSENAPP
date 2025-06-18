import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart'; // Required for SystemChrome

// --- Dosen Model ---
// models/dosen_model.dart
class Dosen {
  final int? no; // 'no' can be null for new Dosen before it's assigned by backend
  final String nip;
  final String namaLengkap;
  final String noTelepon;
  final String email;
  final String alamat;

  Dosen({
    this.no,
    required this.nip,
    required this.namaLengkap,
    required this.noTelepon,
    required this.email,
    required this.alamat,
  });

  // Factory constructor to create a Dosen from a JSON map
  factory Dosen.fromJson(Map<String, dynamic> json) {
    return Dosen(
      no: json['no'] as int?,
      nip: json['nip'] as String,
      namaLengkap: json['nama_lengkap'] as String,
      noTelepon: json['no_telepon'] as String,
      email: json['email'] as String,
      alamat: json['alamat'] as String,
    );
  }

  // Method to convert Dosen object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'nip': nip,
      'nama_lengkap': namaLengkap,
      'no_telepon': noTelepon,
      'email': email,
      'alamat': alamat,
    };
  }

  // Method to convert Dosen object to a JSON map for update (including 'no')
  Map<String, dynamic> toUpdateJson() {
    return {
      'no': no, // Include 'no' for identification in update requests
      'nip': nip,
      'nama_lengkap': namaLengkap,
      'no_telepon': noTelepon,
      'email': email,
      'alamat': alamat,
    };
  }
}
