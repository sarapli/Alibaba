import 'dart:ui';

import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'My Profile',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w900),
                ),
                const Spacer(),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Logout'),
                ),
              ],
            ),
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.03),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: Colors.black.withValues(alpha: 0.08)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 86,
                        height: 86,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withValues(alpha: 0.06),
                          border: Border.all(color: Colors.black.withValues(alpha: 0.08)),
                        ),
                        child: const Icon(Icons.person, size: 46),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 160,
                        child: FilledButton(
                          onPressed: () {},
                          child: const Text('Edit Profile'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const _InfoRow(icon: Icons.person_outline, label: 'Name', value: 'Rakib Bhuiyan'),
                      const SizedBox(height: 10),
                      const _InfoRow(icon: Icons.email_outlined, label: 'Email', value: 'rakib205@gmail.com'),
                      const SizedBox(height: 10),
                      const _InfoRow(icon: Icons.calendar_month_outlined, label: 'Member Since', value: '25-03-2020'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.black.withValues(alpha: 0.55)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.black.withValues(alpha: 0.55)),
          ),
        ),
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}
