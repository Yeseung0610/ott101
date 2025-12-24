import 'package:flutter/cupertino.dart';

class StarRangeBar extends StatelessWidget {
  const StarRangeBar({super.key, required this.starRate});

  final double starRate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildStar(2 <= starRate),
        _buildStar(4 <= starRate),
        _buildStar(6 <= starRate),
        _buildStar(8 <= starRate),
        _buildStar(10 <= starRate),
      ],
    );
  }

  Widget _buildStar(bool fill) {
    return Image.asset(
      fill ? 'assets/KakaoTalk_20251220_103517369_01.png' : 'assets/KakaoTalk_20251220_103517369.png',
      width: 30,
      height: 30,
    );
  }
}
