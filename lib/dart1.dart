class Data{
  late String noticeid;
  late String notice_type;
  late String equip;
  late String purchase_date;
  late String equip_description;
  late String description;
  late String loc_description;
  late String notice_date;
  late String notice_time;
  late String timezone;
  late String ext_num;
  Data(this.noticeid,this.notice_type,this.equip,this.purchase_date,this.equip_description,this.description,this.loc_description,this.notice_date,this.notice_time,
  this.timezone,this.ext_num);
  Data.get(Map<String,dynamic>data){
    noticeid=data["NOTIFICAT"];
    notice_type=data["NOTIF_TYPE"];
    equip=data["EQUIPMENT"];
    purchase_date=data["PURCH_DATE"];
    equip_description=data["EQUIDESCR"];
    description=data["DESCRIPT"];
    loc_description=data["FUNCLDESCR"];
    notice_date=data["NOTIFDATE"];
    notice_time=data["NOTIFTIME"];
    timezone=data["PRIOTYPE"];
    ext_num=data["EXTERNAL_NUMBER"];
}
}