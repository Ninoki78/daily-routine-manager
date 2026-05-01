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
<<<<<<< HEAD
=======
    final c = color ?? Theme.of(context).primaryColor;

>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
<<<<<<< HEAD
            valueColor: AlwaysStoppedAnimation<Color>(
              color ?? Theme.of(context).primaryColor,
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
=======
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
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
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
<<<<<<< HEAD
  
=======

>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
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
<<<<<<< HEAD
=======
  late Animation<double> _animation;
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41

  @override
  void initState() {
    super.initState();
<<<<<<< HEAD
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
=======

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();

    _animation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

<<<<<<< HEAD
=======
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

>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.itemCount,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return Card(
<<<<<<< HEAD
          margin: const EdgeInsets.only(bottom: 16),
=======
          margin: const EdgeInsets.only(bottom: 14),
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
<<<<<<< HEAD
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 16),
=======
                _shimmerBox(
                  height: 50,
                  width: 50,
                  radius: BorderRadius.circular(10),
                ),
                const SizedBox(width: 14),

>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
<<<<<<< HEAD
                      Container(
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 12,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
=======
                      _shimmerBox(height: 14),
                      const SizedBox(height: 10),
                      _shimmerBox(height: 12, width: 160),
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
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