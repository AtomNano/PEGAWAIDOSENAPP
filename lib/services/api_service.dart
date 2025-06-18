import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/dosen_model.dart';
import 'package:pegawaidosenapp/models/dosen_model.dart'; // Required for SystemChrome


class ApiService {
  // Use your local machine's IP address if running on a physical device,
  // or '10.0.2.2' for Android emulator, 'localhost' for iOS simulator/web.
  // The user provided '10.126.193.85', so I will use that.
  static const String _baseUrl = 'http://192.168.100.100:8000/api/dosen';

  // Fetch all Dosen
  Future<List<Dosen>> fetchDosen() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        // Assuming the API returns a list of Dosen directly, not nested under 'dosen' key
        // If it's nested like `{"dosen": [...]}` then use: final List<dynamic> data = json.decode(response.body)['dosen'];
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Dosen.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load dosen: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching dosen: $e');
    }
  }

  // Add a new Dosen
  Future<void> addDosen(Dosen dosen) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(dosen.toJson()),
      );

      if (response.statusCode != 201 && response.statusCode != 200) {
        // Assuming 201 for creation success, or 200 if backend returns that.
        throw Exception('Failed to add dosen: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Error adding dosen: $e');
    }
  }

  // Update an existing Dosen
  Future<void> updateDosen(Dosen dosen) async {
    if (dosen.no == null) {
      throw Exception('Dosen ID (no) is required for update.');
    }
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/${dosen.no}'), // Assuming update uses /api/dosen/{no}
        headers: {'Content-Type': 'application/json'},
        body: json.encode(dosen.toUpdateJson()), // Use toUpdateJson to include 'no' in payload if needed by backend, otherwise use toJson()
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update dosen: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Error updating dosen: $e');
    }
  }

  // Delete a Dosen
  Future<void> deleteDosen(int no) async {
    try {
      final response = await http.delete(Uri.parse('$_baseUrl/$no')); // Assuming delete uses /api/dosen/{no}

      if (response.statusCode != 200 && response.statusCode != 204) {
        // Assuming 200 for success or 204 for no content after deletion
        throw Exception('Failed to delete dosen: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Error deleting dosen: $e');
    }
  }
}