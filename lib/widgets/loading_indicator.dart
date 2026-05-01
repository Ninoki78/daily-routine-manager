import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final String? message;
  final Color? color;

  const LoadingIndicator({
    super.key,
    this.message,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? Theme.of(context).primaryColor;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(c),
          ),
          if (message != null) ...[
            const SizedBox(height: 14),
            Text(
              message!,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

class ShimmerLoading extends StatefulWidget {
  final int itemCount;

  const ShimmerLoading({
    super.key,
    this.itemCount = 5,
  });

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();

    _animation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _shimmerBox({
    required double height,
    double? width,
    BorderRadius? radius,
  }) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: radius ?? BorderRadius.circular(6),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.itemCount,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 14),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                _shimmerBox(
                  height: 50,
                  width: 50,
                  radius: BorderRadius.circular(10),
                ),
                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _shimmerBox(height: 14),
                      const SizedBox(height: 10),
                      _shimmerBox(height: 12, width: 160),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}