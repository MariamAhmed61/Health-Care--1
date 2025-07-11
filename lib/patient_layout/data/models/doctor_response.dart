class Doctor {
  Doctor({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.specialization,
    this.address,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.verificationCode,
    this.verificationCodeExpires,
    this.averageRating,
    this.ratings,
    this.availableSlots,
    this.price,
    this.balance,
  });

  Doctor.fromJson(dynamic json) {
    id = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    specialization = json['specialization'];
    address = json['address'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    verificationCode = json['verificationCode'];
    verificationCodeExpires = json['verificationCodeExpires'];
    averageRating = json['averageRating'];
    if (json['ratings'] != null) {
      ratings = [];
      json['ratings'].forEach((v) {
        ratings?.add(Ratings.fromJson(v));
      });
    }
    if (json['availableSlots'] != null) {
      availableSlots = [];
      json['availableSlots'].forEach((v) {
        availableSlots?.add(AvailableSlot.fromJson(v));
      });
    }
    price = json['price'];
    balance = json['balance'];
  }

  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? specialization;
  String? address;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? verificationCode;
  String? verificationCodeExpires;
  String? averageRating;
  List<Ratings>? ratings;
  List<AvailableSlot>? availableSlots;
  int? price;
  int? balance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['email'] = email;
    map['phoneNumber'] = phoneNumber;
    map['specialization'] = specialization;
    map['address'] = address;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    map['verificationCode'] = verificationCode;
    map['verificationCodeExpires'] = verificationCodeExpires;
    map['averageRating'] = averageRating;
    if (ratings != null) {
      map['ratings'] = ratings?.map((v) => v.toJson()).toList();
    }
    if (availableSlots != null) {
      map['availableSlots'] = availableSlots?.map((v) => v.toJson()).toList();
    }
    map['price'] = price;
    map['balance'] = balance;
    return map;
  }
}

class Ratings {
  Ratings({
    this.userId,
    this.rating,
    this.comment,
    this.id,
  });

  Ratings.fromJson(dynamic json) {
    userId = json['userId'];
    rating = json['rating'];
    comment = json['comment'];
    id = json['_id'];
  }

  String? userId;
  int? rating;
  String? comment;
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['rating'] = rating;
    map['comment'] = comment;
    map['_id'] = id;
    return map;
  }
}

class AvailableSlot {
  AvailableSlot({
    this.date,
    this.times,
    this.id,
  });

  AvailableSlot.fromJson(dynamic json) {
    date = json['date'];
    times = json['times'] != null ? List<String>.from(json['times']) : null;
    id = json['_id'];
  }

  String? date;
  List<String>? times;
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = date;
    map['times'] = times;
    map['_id'] = id;
    return map;
  }
}
