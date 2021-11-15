class Company {
    Company({
        required this.id,
        required this.name,
        required this.banned,
        required this.image,
        required this.location,
        required this.verified,
        required this.phoneNumber,
        required this.emailAddress,
        required this.companyDescription,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
    });

    final int? id;
    final String? name;
    final bool banned;
    final String? image;
    final String? location;
    final bool verified;
    final String? phoneNumber;
    final String? emailAddress;
    final String? companyDescription;
    final DateTime createdAt;
    final DateTime updatedAt;
    final dynamic deletedAt;

    factory Company.fromJson(Map<String?, dynamic> json) => Company(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        banned: json["banned"] == null ? null : json["banned"],
        image: json["image"] == null ? null : json["image"],
        location: json["location"] == null ? null : json["location"],
        verified: json["verified"] == null ? null : json["verified"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        emailAddress: json["email_address"] == null ? null : json["email_address"],
        companyDescription: json["company_description"] == null ? null : json["company_description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
    );

    Map<String?, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "banned": banned,
        "image": image == null ? null : image,
        "location":  location,
        "verified":  verified,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "email_address": emailAddress == null ? null : emailAddress,
        "company_description": companyDescription == null ? null : companyDescription,
        "created_at":createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
    };
}