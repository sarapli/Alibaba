import 'dart:ui';

import 'package:flutter/material.dart';

class BlogTab extends StatelessWidget {
  const BlogTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            title: const Text('Blog'),
            actions: [
              PopupMenuButton<String>(
                itemBuilder: (context) => const [
                  PopupMenuItem(value: 'recent', child: Text('Most Recent')),
                  PopupMenuItem(value: 'popular', child: Text('Most Popular')),
                ],
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList.separated(
              itemBuilder: (context, i) => const _BlogCard(),
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemCount: 6,
            ),
          ),
        ],
      ),
    );
  }
}

class _BlogCard extends StatelessWidget {
  const _BlogCard();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                'https://images.unsplash.com/photo-1526778548025-fa2f459cd5c1?auto=format&fit=crop&w=1400&q=80',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    color: Colors.white.withValues(alpha: 0.14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Re-Evaluating Summer Travel Is Easier Said Than Done',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.white, fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Text(
                              'forbes',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.white.withValues(alpha: 0.85)),
                            ),
                            const Spacer(),
                            const Icon(Icons.favorite, size: 16, color: Colors.white),
                            const SizedBox(width: 6),
                            Text(
                              '4',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.white.withValues(alpha: 0.85)),
                            ),
                          ],
                        ),
                      ],
                    ),
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
