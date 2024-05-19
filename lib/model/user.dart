class Users {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? role;
  String? area;

  Users({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.role,
    this.area,
  });

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    role = json['role'];
    area = json['area'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['name'] = name;
    data['phone'] = phone;
    data['role'] = role;
    data['area'] = area;
    return data;
  }
}
