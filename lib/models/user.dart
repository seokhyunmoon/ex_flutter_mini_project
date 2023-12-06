class User {
  int? id;
  String? email;
  String? name;
  String? tier;
  int? playgroundId;
  bool? isActive;
  String? tel;
  int? startYear;
  int? teamId;

  User({
    this.id,
    this.email,
    this.name,
    this.tier,
    this.playgroundId,
    this.isActive,
    this.tel,
    this.startYear,
    this.teamId,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as int?,
        email: json['email'] as String?,
        name: json['name'] as String?,
        tier: json['tier'] as String?,
        playgroundId: json['playgroundId'] as int?,
        isActive: json['isActive'] as bool?,
        tel: json['tel'] as String?,
        startYear: json['start_year'] as int?,
        teamId: json['teamId'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'name': name,
        'tier': tier,
        'playgroundId': playgroundId,
        'isActive': isActive,
        'tel': tel,
        'start_year': startYear,
        'teamId': teamId,
      };
}
