enum CallsEnum {
  audio('audio'),
  video('video');

  const CallsEnum(this.type);
  final String type;
}

extension ConvertMessage on String {
  CallsEnum toEnum() {
    switch (this) {
      case 'audio':
        return CallsEnum.audio;
      case 'video':
        return CallsEnum.video;
      default:
        return CallsEnum.video;
    }
  }
}
