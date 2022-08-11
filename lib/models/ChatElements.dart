// ignore_for_file: non_constant_identifier_names

class chatsElements{
  //data Type

  String? MyEmail;
  String? SenderEmail ;
  String?MyImage ;
    String?SenderImage ;
   String? date;
    String? SenderName ;
     String? TextMessage;
      String? WhoSender;
       String? TypeMessage;
       String? LastMessage;
       String? MessageView;


// constructor
  chatsElements(
      {
      this.MyEmail,
       this.SenderEmail,
      this.MyImage,
      this.SenderImage,
      this.date,
        this. SenderName,
        this.TextMessage ,
        this. WhoSender,
        this.TypeMessage ,
        this.LastMessage ,
        this. MessageView,
       


      }
   );
  //method that assign values to respective datatype vairables
  chatsElements.fromJson(Map<String,dynamic> json)
  {
      
     MyEmail = json['MyEmail'];
     SenderEmail = json['SenderEmail'];
     MyImage = json['MyImage'];
     SenderImage = json['SenderImage'];
      date= json['date'];
     SenderName = json['SenderName'];
     TextMessage = json['TextMessage'];
      WhoSender= json['WhoSender'];
      TypeMessage= json['TypeMessage'];
     LastMessage = json['LastMessage'];
     MessageView = json['MessageView'];
      

    
  }
   factory chatsElements.fromMap(Map<String, dynamic> json) => chatsElements(
        MyEmail :json['MyEmail'],
     SenderEmail : json['SenderEmail'],
     MyImage : json['MyImage'],
     SenderImage : json['SenderImage'],
      date: json['date'],
     SenderName : json['SenderName'],
     TextMessage : json['TextMessage'],
      WhoSender: json['WhoSender'],
      TypeMessage: json['TypeMessage'],
     LastMessage : json['LastMessage'],
     MessageView : json['MessageView'],
      );
}





