class userInfo {
   String? email;
   String? name;
   String? image;
   String? work;
    String? followers;
    String? Ifollow;
    String? evaluation;
    String? description;


  userInfo({
     this.email,
     this.name,
    this.image,
     this.work,
      this.followers,
        this.Ifollow,
       this.evaluation,
       this.description,




  });

  userInfo.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    image = json['image'];
    work = json['work'];
   followers = json['followers'];
   Ifollow = json['Ifollow'];
   evaluation = json['evaluation'];
   description = json['description'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['email'] = email;
    data['name'] =name;
    data['image'] =image;
    data['work'] =work;
    data['followers'] = followers;
    data['Ifollow'] = Ifollow;
    data['evaluation'] = evaluation;
    data['description'] = description;


    return data;
  }

    factory userInfo.fromMap(Map<String, dynamic> json) => userInfo(
        email: json["email"],
        name: json["name"],
        image: json["image"],
        work : json['work'],
      followers: json['followers'],
     Ifollow: json['Ifollow'],
      evaluation: json['evaluation'],
      description: json['description'],

      );
}


