enum Sex { Male, Female }

extension SexExtension on Sex {
  String get value {
    switch (this) {
      case Sex.Male:
        return 'Мужской';
      case Sex.Female:
        return 'Женский';
      default:
        return null;
    }
  }
}
