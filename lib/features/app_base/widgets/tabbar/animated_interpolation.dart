import 'package:flutter/material.dart';

class InterpolationTween extends Animatable<double> {
  InterpolationTween({
    required this.inputRange,
    required this.outputRange,
    this.curve = const _Linear._(),
    this.extrapolate,
    this.extrapolateLeft = ExtrapolateType.clamp,
    this.extrapolateRight = ExtrapolateType.clamp,
  });

  final List<double> inputRange;
  final List<double> outputRange;
  final Curve curve;
  final ExtrapolateType? extrapolate;
  final ExtrapolateType extrapolateLeft;
  final ExtrapolateType extrapolateRight;

  @override
  double transform(double t) => createInterpolation(InterpolationConfigType(
      inputRange: inputRange,
      outputRange: outputRange,
      curve: curve,
      extrapolate: extrapolate,
      extrapolateLeft: extrapolateLeft,
      extrapolateRight: extrapolateRight))(t);
}

enum ExtrapolateType {
  extend,
  identity,
  clamp,
}

typedef DoubleCallBack<double> = double Function(double value);

class _Linear extends Curve {
  const _Linear._();

  @override
  double transformInternal(double t) => t;
}

class InterpolationConfigType {
  InterpolationConfigType({
    required this.inputRange,
    required this.outputRange,
    this.curve = const _Linear._(),
    this.extrapolate,
    this.extrapolateLeft = ExtrapolateType.extend,
    this.extrapolateRight = ExtrapolateType.extend,
  })  : assert(inputRange.length >= 2),
        assert(outputRange.length >= 2),
        assert(inputRange.length == outputRange.length);

  final List<double> inputRange;
  final List<double> outputRange;
  final Curve curve;
  final ExtrapolateType? extrapolate;
  final ExtrapolateType extrapolateLeft;
  final ExtrapolateType extrapolateRight;
}

int findRange(double input, List<double> inputRange) {
  if (inputRange.length <= 1) {
    return 0;
  }
  int i;
  for (i = 1; i < inputRange.length - 1; ++i) {
    if (inputRange[i] >= input) {
      break;
    }
  }
  return i - 1;
}

DoubleCallBack<double> createInterpolation(InterpolationConfigType config) {
  return (double input) {
    int range = findRange(input, config.inputRange);

    ExtrapolateType extrapolateLeft = config.extrapolateLeft;
    if (config.extrapolate != null) extrapolateLeft = config.extrapolate!;

    ExtrapolateType extrapolateRight = config.extrapolateRight;
    if (config.extrapolate != null) extrapolateRight = config.extrapolate!;

    return interpolate(
      input: input,
      inputMin: config.inputRange[range],
      inputMax: config.inputRange[range + 1],
      outputMin: config.outputRange[range],
      outputMax: config.outputRange[range + 1],
      curve: config.curve,
      extrapolateLeft: extrapolateLeft,
      extrapolateRight: extrapolateRight,
    );
  };
}

double interpolate({
  required double input,
  required double inputMin,
  required double inputMax,
  required double outputMin,
  required double outputMax,
  Curve curve = const _Linear._(),
  required ExtrapolateType extrapolateLeft,
  required ExtrapolateType extrapolateRight,
}) {
  double result = input;

  // Extrapolate
  if (result < inputMin) {
    if (extrapolateLeft == ExtrapolateType.identity) {
      return result;
    } else if (extrapolateLeft == ExtrapolateType.clamp) {
      result = inputMin;
    } else if (extrapolateLeft == ExtrapolateType.extend) {
      // noop
    }
  }

  if (result > inputMax) {
    if (extrapolateRight == ExtrapolateType.identity) {
      return result;
    } else if (extrapolateRight == ExtrapolateType.clamp) {
      result = inputMax;
    } else if (extrapolateRight == ExtrapolateType.extend) {
      // noop
    }
  }

  if (outputMin == outputMax) {
    return outputMin;
  }

  if (inputMin == inputMax) {
    if (input <= inputMin) {
      return outputMin;
    }
    return outputMax;
  }

  // Input Range
  if (inputMin == -double.infinity) {
    result = -result;
  } else if (inputMax == double.infinity) {
    result = result - inputMin;
  } else {
    result = (result - inputMin) / (inputMax - inputMin);
  }

  // Easing
  if (curve == null) curve = _Linear._();
  result = curve.transform(result);

  // Output Range
  if (outputMin == -double.infinity) {
    result = -result;
  } else if (outputMax == double.infinity) {
    result = result + outputMin;
  } else {
    result = result * (outputMax - outputMin) + outputMin;
  }

  return result;
}
