import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  String? documentId;
  String? image;
  String? name;
  String? serviceType;
  String? phone;
  String? job;
  String? address;
  DateTime? birthdate;
  int? birthdateDay;
  int? birthdateMonth;
  int? marriageDateDay;
  int? marriageDateMonth;
  DateTime? lastConfessionDate;
  String? maritalStatus;
  String? addictionType;
  String? materialType;
  String? previousSetbacks;
  DateTime? addictionStartDate;
  DateTime? lastRecoveryDate;
  DateTime? marriageDate;
  DateTime? createdAt;
  String? wifeName;
  String? aboutChildren;
  String? notes;

  UserModel({
    required this.image,
    required this.name,
    required this.serviceType,
    required this.phone,
    required this.job,
    required this.address,
    required this.birthdate,
    required this.birthdateDay,
    required this.birthdateMonth,
    required this.marriageDateDay,
    required this.marriageDateMonth,
    required this.lastConfessionDate,
    required this.maritalStatus,
    required this.addictionType,
    required this.materialType,
    required this.previousSetbacks,
    required this.addictionStartDate,
    required this.lastRecoveryDate,
    required this.marriageDate,
    required this.wifeName,
    required this.aboutChildren,
    this.createdAt,
    this.documentId,
    required this.notes,
  });

  // From JSON method
  factory UserModel.fromJson(
      {required Map<String, dynamic> json, String? documentId}) {
    return UserModel(
      documentId: documentId ?? json['documentId'],
      image: json['image'] as String?,
      birthdateDay: json['birthdateDay'],
      birthdateMonth: json['birthdateMonth'],
      marriageDateDay: json['marriageDateDay'],
      marriageDateMonth: json['marriageDateMonth'],
      serviceType: json['serviceType'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      job: json['job'] as String?,
      address: json['address'] as String?,
      birthdate: json['birthdate'] != null
          ? DateTime.parse(json['birthdate'] as String)
          : null,
      lastConfessionDate: json['lastConfessionDate'] != null
          ? DateTime.parse(json['lastConfessionDate'] as String)
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      maritalStatus: json['maritalStatus'] as String?,
      addictionType: json['addictionType'] as String?,
      materialType: json['materialType'] as String?,
      previousSetbacks: json['previousSetbacks'] as String?,
      addictionStartDate: json['addictionStartDate'] != null
          ? DateTime.parse(json['addictionStartDate'] as String)
          : null,
      lastRecoveryDate: json['lastRecoveryDate'] != null
          ? DateTime.parse(json['lastRecoveryDate'] as String)
          : null,
      marriageDate: json['marriageDate'] != null
          ? DateTime.parse(json['marriageDate'] as String)
          : null,
      wifeName: json['wifeName'] as String?,
      aboutChildren: json['aboutChildren'] as String?,
      notes: json['notes'] as String?,
    );
  }

  // To JSON method
  Map<String, dynamic> toJson() {
    return {
      if (documentId != null) 'documentId': documentId,
      'image': image,
      'serviceType': serviceType,
      'name': name,
      'phone': phone,
      'job': job,
      'address': address,
      'birthdate': birthdate?.toIso8601String(),
      'birthdateDay': birthdateDay,
      'birthdateMonth': birthdateMonth,
      'marriageDateDay': marriageDateDay,
      'marriageDateMonth': marriageDateMonth,
      'lastConfessionDate': lastConfessionDate?.toIso8601String(),
      'maritalStatus': maritalStatus,
      'addictionType': addictionType,
      'materialType': materialType,
      'previousSetbacks': previousSetbacks,
      'addictionStartDate': addictionStartDate?.toIso8601String(),
      'lastRecoveryDate': lastRecoveryDate?.toIso8601String(),
      'marriageDate': marriageDate?.toIso8601String(),
     if(createdAt!=null) 'createdAt': createdAt?.toIso8601String(),
      'wifeName': wifeName,
      'aboutChildren': aboutChildren,
      'notes': notes,
    };
  }

  @override
  List<Object?> get props => [
        image,
        name,
        serviceType,
        phone,
        job,
        address,
        birthdate,
        birthdateDay,
        birthdateMonth,
        lastConfessionDate,
        maritalStatus,
        addictionType,
        materialType,
        previousSetbacks,
        addictionStartDate,
        lastRecoveryDate,
        marriageDate,
        wifeName,
        aboutChildren,
        createdAt,
        documentId,
        notes,
        marriageDateMonth,
        marriageDateDay,
      ];
}
