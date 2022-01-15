enum SplitType {
  Equally,
  Unequally,
  Adjustment,
  Percentage,
  Shares,
}
enum AvatarID {
  none,
  Female1,
  Female2,
  Female3,
  Male1,
  Male2,
  Male3,
}

String getAvatarByID(AvatarID avatarID) {
  switch (avatarID) {
    case AvatarID.Female1:
      return 'assets/vectors/female-avatar-1.svg';
    case AvatarID.Female2:
      return 'assets/vectors/female-avatar-2.svg';
    case AvatarID.Female3:
      return 'assets/vectors/female-avatar-3.svg';
    case AvatarID.Male1:
      return 'assets/vectors/male-avatar-1.svg';
    case AvatarID.Male2:
      return 'assets/vectors/male-avatar-2.svg';
    case AvatarID.Male3:
      return 'assets/vectors/male-avatar-3.svg';
    case AvatarID.none:
      return 'assets/vectors/female-avatar-1.svg';
  }
}

String getSplitNameByType(SplitType splitType) {
  switch (splitType) {
    case SplitType.Adjustment:
      return 'By Adjustment';
    case SplitType.Equally:
      return 'Equally';
    case SplitType.Percentage:
      return 'By Percentage';
    case SplitType.Unequally:
      return 'Unequally';
    case SplitType.Shares:
      return 'By Shares';
  }
}
