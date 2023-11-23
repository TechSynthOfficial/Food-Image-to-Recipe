class UserModel {
  String? Uid;
  String? Name;
  String? Email;
  String? Company;
  String? Age;
  String? Cook;
  String? Researcher;
  String? Pic;

  UserModel ({this.Uid,this.Name,this.Email,this.Age,this.Cook,this.Pic});

  UserModel.fromMap(Map<String,dynamic> map){
    Uid = map['Uid'];
    Name = map['Name'];
    Email = map['Email'];
    Age =  map['Age'];
    Cook=map['Cook'];
    // Company = map['Company'];
    // Researcher = map['Researcher'];
    Pic = map['Pic'];
  }

  Map<String,dynamic> toMap(){
    return {
      "Uid":Uid,
      "Name": Name,
      "Email": Email,
      "Company": Company,
      "Researcher":Researcher,
      "Pic": Pic
    };
  }

}