class DetailsModel {
  String? coreSerial;
  int? block;
  String? status;
  String? originalLaunch;
  int? originalLaunchUnix;
  List<Missions>? missions;
  int? reuseCount;
  int? rtlsAttempts;
  int? rtlsLandings;
  int? asdsAttempts;
  int? asdsLandings;
  bool? waterLanding;
  String? details;

  DetailsModel(
      {this.coreSerial,
        this.block,
        this.status,
        this.originalLaunch,
        this.originalLaunchUnix,
        this.missions,
        this.reuseCount,
        this.rtlsAttempts,
        this.rtlsLandings,
        this.asdsAttempts,
        this.asdsLandings,
        this.waterLanding,
        this.details});

  DetailsModel.fromJson(Map<dynamic, dynamic> json) {
    coreSerial = json['core_serial'];
    block = json['block'];
    status = json['status'];
    originalLaunch = json['original_launch'];
    originalLaunchUnix = json['original_launch_unix'];
    if (json['missions'] != null) {
      missions = <Missions>[];
      json['missions'].forEach((v) {
        missions!.add(Missions.fromJson(v));
      });
    }
    reuseCount = json['reuse_count'];
    rtlsAttempts = json['rtls_attempts'];
    rtlsLandings = json['rtls_landings'];
    asdsAttempts = json['asds_attempts'];
    asdsLandings = json['asds_landings'];
    waterLanding = json['water_landing'];
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['core_serial'] = coreSerial;
    data['block'] = block;
    data['status'] = status;
    data['original_launch'] = originalLaunch;
    data['original_launch_unix'] = originalLaunchUnix;
    if (missions != null) {
      data['missions'] = missions!.map((v) => v.toJson()).toList();
    }
    data['reuse_count'] = reuseCount;
    data['rtls_attempts'] = rtlsAttempts;
    data['rtls_landings'] = rtlsLandings;
    data['asds_attempts'] = asdsAttempts;
    data['asds_landings'] = asdsLandings;
    data['water_landing'] = waterLanding;
    data['details'] = details;
    return data;
  }
}

class Missions {
  String? name;
  int? flight;

  Missions({this.name, this.flight});

  Missions.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    flight = json['flight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['flight'] = flight;
    return data;
  }
}