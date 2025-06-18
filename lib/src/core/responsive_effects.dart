part of 'package:responsive_master/responsive_master.dart';

class ResponsiveTransitionBuilder {
  static AnimatedSwitcherTransitionBuilder resolve(ResponsiveTransition type) {
    switch (type) {
      case ResponsiveTransition.fade:
        return _fade;
      case ResponsiveTransition.slide:
        return _slide;
      case ResponsiveTransition.scale:
        return _scale;
      case ResponsiveTransition.slideScale:
        return _slideScale;
      case ResponsiveTransition.flip:
        return _flip;
      case ResponsiveTransition.rotation:
        return _rotation;
    }
  }

  static Widget _fade(Widget child, Animation<double> animation) {
    return FadeTransition(opacity: animation, child: child);
  }

  static Widget _slide(Widget child, Animation<double> animation) {
    final offset = Tween<Offset>(
      begin: const Offset(0.0, 0.1),
      end: Offset.zero,
    ).animate(animation);

    return SlideTransition(position: offset, child: child);
  }

  static Widget _scale(Widget child, Animation<double> animation) {
    final scale = Tween<double>(begin: 0.95, end: 1.0).animate(animation);
    return ScaleTransition(scale: scale, child: child);
  }

  static Widget _slideScale(Widget child, Animation<double> animation) {
    final offset = Tween<Offset>(
      begin: const Offset(0.0, 0.1),
      end: Offset.zero,
    ).animate(animation);

    final scale = Tween<double>(begin: 0.95, end: 1.0).animate(animation);

    return SlideTransition(
      position: offset,
      child: ScaleTransition(scale: scale, child: child),
    );
  }

  static Widget _rotation(Widget child, Animation<double> animation) {
    return RotationTransition(
      turns: Tween<double>(begin: 0.97, end: 1.0).animate(animation),
      child: child,
    );
  }

  static Widget _flip(Widget child, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) {
        final value = animation.value;
        final isUnder = value > 0.5;
        final rotationValue = isUnder ? (1 - value) * 3.14159 : value * 3.14159;

        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001) // perspective
            ..rotateY(rotationValue),
          child: child,
        );
      },
    );
  }
}
