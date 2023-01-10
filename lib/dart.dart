class Data{
  late String orderid;
  late String date;
  late String activity;
  late String work_center;
  late String plant;
  late String description;
  late String confirmation_no;
  late String start_date;
  late String start_time;
  late String end_date;
  late String end_time;
  Data(this.orderid,this.date,this.activity,this.work_center,this.plant,this.description,this.confirmation_no,this.start_date,this.start_time,
  this.end_date,this.end_time);
  Data.get(Map<String,dynamic>data){
    orderid=data["ORDERID"];
    date=data["EARL_SCHED_START_DATE"];
    activity=data["ACTIVITY"];
    work_center=data["WORK_CNTR"];
    plant=data["PLANT"];
    description=data["DESCRIPTION"];
    confirmation_no=data["CONF_NO"];
    start_date=data["EARL_SCHED_START_DATE"];
    start_time=data["EARL_SCHED_START_TIME"];
    end_date=data["EARL_SCHED_FINISH_DATE"];
    end_time=data["EARL_SCHED_FINISH_TIME"];
}
}