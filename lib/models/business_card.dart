const businessCardsTable = 'cards';

class BusinessCard {
  int id;
  String name;
  String email;
  String phone;
  String company;
  String address;
  String site;

  BusinessCard();

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      "name": name,
      "email": email,
      "phone": phone,
      "company": company,
      "address": address,
      "site": site,
    };

    if (id != null) map['id'] = id;

    return map;
  }

  BusinessCard.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    email = map['email'];
    phone = map['phone'];
    company = map['company'];
    address = map['address'];
    site = map['site'];
  }
}
