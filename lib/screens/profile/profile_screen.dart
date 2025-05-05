import 'package:drilly/utils/custom/custom_widget.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50,right: 20,left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: ClipOval(
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: CustomNetworkImage("url"),
                ),
              )
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                'Catherine Massey',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildInfoColumn('80', 'Posts'),
                _buildInfoColumn('110', 'Followers'),
                _buildInfoColumn('152', 'Following'),
              ],
            ),
            const SizedBox(height: 16),
            // Nút Message và Follow
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildActionButton('Message', Colors.blue),
                const SizedBox(width: 16),
                _buildActionButton('Follow', Colors.blueAccent),
              ],
            ),
            const SizedBox(height: 16),
            // Hình ảnh (grid ảnh)
          ],
        ),
      ),
    );
  }

  // Xây dựng thông tin Posts, Followers, Following
  Widget _buildInfoColumn(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 16, color: Colors.grey)),
      ],
    );
  }

  // Xây dựng các nút hành động như Message và Follow
  Widget _buildActionButton(String label, Color color) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(label, style: const TextStyle(fontSize: 16)),
    );
  }
}