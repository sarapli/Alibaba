import 'package:flutter/material.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Settings',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 14),
          const _Tile(
            icon: Icons.email_outlined,
            title: 'Support Email',
            subtitle: 'mrblabla24@gmail.com',
          ),
          const _Tile(icon: Icons.star_border, title: 'Rate & Review'),
          const _Tile(icon: Icons.lock_outline, title: 'Privacy Policy'),
          const _Tile(icon: Icons.description_outlined, title: 'Licence'),
          const _Tile(icon: Icons.info_outline, title: 'App Version', subtitle: '2.0.0'),
          const _Tile(icon: Icons.shopping_cart_outlined, title: 'Purchase', subtitle: 'Full source code'),
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({required this.icon, required this.title, this.subtitle});

  final IconData icon;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
        ),
        child: Icon(icon, color: Colors.black.withValues(alpha: 0.70)),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w900,
            ),
      ),
      subtitle: subtitle == null ? null : Text(subtitle!),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}
