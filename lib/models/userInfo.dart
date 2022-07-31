class userInfo {
  late String email;
  late String name;
  late String image;
  late String work;
   late List followers;
   late List Ifollow;
   late List evaluation;
   late List description;


  userInfo({
    required this.email,
    required this.name,
   required this.image,
    required this.work,
     required this.followers,
       required this.Ifollow,
      required this.evaluation,
      required this.description,




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
}