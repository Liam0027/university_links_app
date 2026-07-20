import 'package:flutter/material.dart';
import 'package:university_links_app/ui/utils/focus_mode.dart';
import '../../core/app_colors.dart';
import '../pages/search_page.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 70),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primary, AppColors.secondary],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(top: -110, right: -60, child: _decorCircle(220)),
              Positioned(bottom: -90, left: -40, child: _decorCircle(140)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Builder(
                        builder: (ctx) => _GlassIconButton(
                          icon: Icons.menu,
                          onTap: () => Scaffold.of(ctx).openDrawer(),
                        ),
                      ),
                      // const _GlassAvatar(text: 'دم'),
                    ],
                  ),
                  const SizedBox(height: 26),
                  const Text(
                    'سلام 👋',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'دانشگاه ملی مهارت استان گیلان',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    'سامانه‌ها و سایت‌های دانشگاه را سریع پیدا کنید',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(bottom: -24, left: 18, right: 18, child: _SearchBar()),
      ],
    );
  }

  Widget _decorCircle(double size) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white.withOpacity(0.08),
    ),
  );
}

class _GlassIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _GlassIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(0.18),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: SizedBox(
          width: 42,
          height: 42,
          child: Icon(icon, color: Colors.white, size: 22),
        ),
      ),
    );
  }
}

// class _GlassAvatar extends StatelessWidget {
//   final String text;

//   const _GlassAvatar({required this.text});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 42,
//       height: 42,
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.18),
//         borderRadius: BorderRadius.circular(14),
//       ),
//       alignment: Alignment.center,
//       child: Text(
//         text,
//         style: const TextStyle(
//           color: Colors.white,
//           fontWeight: FontWeight.bold,
//           fontSize: 15,
//         ),
//       ),
//     );
//   }
// }

class _SearchBar extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: context.isDark ? 0 : 8,
      shadowColor: AppColors.primary.withOpacity(0.28),
      borderRadius: BorderRadius.circular(16),
      child: TextField(
        controller: _controller,
        style: TextStyle(fontSize: 13, color: context.textPrimary),
        decoration: InputDecoration(
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(16.0),
          ),
          filled: true,
          fillColor: context.cardColor,
          contentPadding: const EdgeInsets.all(18.0),
          prefixIcon: Icon(
            Icons.search,
            size: 18,
            color: context.textSecondary,
          ),
          hintText: 'جستجوی سامانه یا سایت...',
          hintStyle: TextStyle(fontSize: 13, color: context.textSecondary),
        ),
        onTapOutside: (event) => unFocus(),
        onChanged: (value) {
          if (value.length == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SearchPage(firstCharInput: value),
              ),
            );
          }
          _controller.clear();
        },
      ),
    );
  }
}
