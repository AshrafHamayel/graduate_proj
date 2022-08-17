class Postt {
   String? name;
   String? id;
   String? imageuser;
    String? imagepost;
    String? date;
    String? description;
    int? numberLike;
   int? numberDisLike;



  Postt({
     this.name,
    this.id,
     this.imageuser,
      this.imagepost,
        this.date,
       this.description,
       this.numberLike,
       this.numberDisLike,





  });

  Postt.fromJson(Map<String, dynamic> json) {
    name = json['name'];
     id = json['id'];
    imageuser = json['imageuser'];
    imagepost = json['imagepost'];
   date = json['date'];
   description = json['description'];
   numberLike = json['numberLike'];
   numberDisLike = json['numberDisLike'];
     



  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] =name;
    data['id'] =id;
    data['imageuser'] =imageuser;
    data['imagepost'] = imagepost;
    data['date'] = date;
    data['description'] = description;
    data['numberLike'] = numberLike;
        data['description'] = numberDisLike;



    return data;
  }

    factory Postt.fromMap(Map<String, dynamic> json) => Postt(
        name: json["name"],
        id: json["id"],
        imageuser : json['imageuser'],
      imagepost: json['imagepost'],
     date: json['date'],
      description: json['description'],
      numberLike: json['numberLike'],
            numberDisLike: json['numberDisLike'],


      );
}


