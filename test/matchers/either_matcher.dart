import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

const isRight = _EitherMatcher(true);
const isLeft = _EitherMatcher(false);

Matcher eitherIsA<T>() => _EitherByTypeMatcher<T>();

Matcher eitherEquals<T>(T value) => _EitherEqualsMatcher<T>(value);

class _EitherMatcher extends Matcher {
  final bool checkRight;

  const _EitherMatcher(this.checkRight);

  @override
  Description describe(Description description) {
    return description;
  }

  @override
  bool matches(item, Map matchState) {
    if (item is! Either) {
      return false;
    }

    if (checkRight) {
      return item.isRight();
    } else {
      return item.isLeft();
    }
  }
}

class _EitherByTypeMatcher<T> extends Matcher {
  const _EitherByTypeMatcher();

  @override
  Description describe(Description description) {
    return description;
  }

  @override
  bool matches(item, Map matchState) {
    if (item is! Either) {
      return false;
    }

    return item.fold((l) => l is T, (r) => r is T);
  }
}

class _EitherEqualsMatcher<T> extends Matcher {
  final T value;
  const _EitherEqualsMatcher(this.value);

  @override
  Description describe(Description description) {
    return description;
  }

  @override
  bool matches(item, Map matchState) {
    if (item is! Either) {
      return false;
    }

    return item.fold((l) => value == l, (r) => value == r);
  }
}
