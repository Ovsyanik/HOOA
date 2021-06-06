enum TypeInstitution {
  HairdressingSalon,
  Barbershop
}

extension TypeInstitutionExtension on TypeInstitution {
  String get value {
    switch (this) {
      case TypeInstitution.HairdressingSalon:
        return 'Парикмахерская';
      case TypeInstitution.Barbershop:
        return 'Барбершоп';
      default:
        return null;
    }
  }
}