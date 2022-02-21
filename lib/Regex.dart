class Regex {
  static RegExp phone = new RegExp(
    r"^\+375 \((17|29|33|44)\) [0-9]{3}-[0-9]{2}-[0-9]{2}$",
    caseSensitive: false,
    multiLine: false,
  );

  static RegExp email = new RegExp(
    r"^([a-z0-9_-]+\.)*[a-z0-9_-]+@[a-z0-9_-]+(\.[a-z0-9_-]+)*\.[a-z]{2,6}$",
    caseSensitive: false,
    multiLine: false,
  );
}
