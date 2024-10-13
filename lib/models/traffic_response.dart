import 'dart:convert';

class TrafficResponse {
    final List<Route> routes;
    final List<Waypoint> waypoints;
    final String code;
    final String uuid;

    TrafficResponse({
        required this.routes,
        required this.waypoints,
        required this.code,
        required this.uuid,
    });

    factory TrafficResponse.fromRawJson(String str) => TrafficResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TrafficResponse.fromJson(Map<String, dynamic> json) => TrafficResponse(
        routes: List<Route>.from(json["routes"].map((x) => Route.fromJson(x))),
        waypoints: List<Waypoint>.from(json["waypoints"].map((x) => Waypoint.fromJson(x))),
        code: json["code"],
        uuid: json["uuid"],
    );

    Map<String, dynamic> toJson() => {
        "routes": List<dynamic>.from(routes.map((x) => x.toJson())),
        "waypoints": List<dynamic>.from(waypoints.map((x) => x.toJson())),
        "code": code,
        "uuid": uuid,
    };
}

class Route {
    final String weightName;
    final double weight;
    final double duration;
    final double distance;
    final List<Leg> legs;
    final String geometry;
    final String voiceLocale;

    Route({
        required this.weightName,
        required this.weight,
        required this.duration,
        required this.distance,
        required this.legs,
        required this.geometry,
        required this.voiceLocale,
    });

    factory Route.fromRawJson(String str) => Route.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Route.fromJson(Map<String, dynamic> json) => Route(
        weightName: json["weight_name"],
        weight: json["weight"]?.toDouble(),
        duration: json["duration"]?.toDouble(),
        distance: json["distance"]?.toDouble(),
        legs: List<Leg>.from(json["legs"].map((x) => Leg.fromJson(x))),
        geometry: json["geometry"],
        voiceLocale: json["voiceLocale"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "weight_name": weightName,
        "weight": weight,
        "duration": duration,
        "distance": distance,
        "legs": List<dynamic>.from(legs.map((x) => x.toJson())),
        "geometry": geometry,
        "voiceLocale": voiceLocale,
    };
}

class Leg {
    final List<dynamic> viaWaypoints;
    final List<Admin> admins;
    final double weight;
    final double duration;
    final List<Step> steps;
    final double distance;
    final String summary;

    Leg({
        required this.viaWaypoints,
        required this.admins,
        required this.weight,
        required this.duration,
        required this.steps,
        required this.distance,
        required this.summary,
    });

    factory Leg.fromRawJson(String str) => Leg.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Leg.fromJson(Map<String, dynamic> json) => Leg(
        viaWaypoints: List<dynamic>.from(json["via_waypoints"].map((x) => x)),
        admins: List<Admin>.from(json["admins"].map((x) => Admin.fromJson(x))),
        weight: json["weight"]?.toDouble(),
        duration: json["duration"]?.toDouble(),
        steps: List<Step>.from(json["steps"].map((x) => Step.fromJson(x))),
        distance: json["distance"]?.toDouble(),
        summary: json["summary"],
    );

    Map<String, dynamic> toJson() => {
        "via_waypoints": List<dynamic>.from(viaWaypoints.map((x) => x)),
        "admins": List<dynamic>.from(admins.map((x) => x.toJson())),
        "weight": weight,
        "duration": duration,
        "steps": List<dynamic>.from(steps.map((x) => x.toJson())),
        "distance": distance,
        "summary": summary,
    };
}

class Admin {
    final String iso31661Alpha3;
    final String iso31661;

    Admin({
        required this.iso31661Alpha3,
        required this.iso31661,
    });

    factory Admin.fromRawJson(String str) => Admin.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Admin.fromJson(Map<String, dynamic> json) => Admin(
        iso31661Alpha3: json["iso_3166_1_alpha3"],
        iso31661: json["iso_3166_1"],
    );

    Map<String, dynamic> toJson() => {
        "iso_3166_1_alpha3": iso31661Alpha3,
        "iso_3166_1": iso31661,
    };
}

class Step {
    final List<VoiceInstruction> voiceInstructions;
    final List<Intersection> intersections;
    final Maneuver maneuver;
    final String name;
    final double duration;
    final double distance;
    final DrivingSide drivingSide;
    final double weight;
    final Mode mode;
    final String geometry;

    Step({
        required this.voiceInstructions,
        required this.intersections,
        required this.maneuver,
        required this.name,
        required this.duration,
        required this.distance,
        required this.drivingSide,
        required this.weight,
        required this.mode,
        required this.geometry,
    });

    factory Step.fromRawJson(String str) => Step.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Step.fromJson(Map<String, dynamic> json) => Step(
        voiceInstructions: List<VoiceInstruction>.from(json["voiceInstructions"].map((x) => VoiceInstruction.fromJson(x))),
        intersections: List<Intersection>.from(json["intersections"].map((x) => Intersection.fromJson(x))),
        maneuver: Maneuver.fromJson(json["maneuver"]),
        name: json["name"],
        duration: json["duration"]?.toDouble(),
        distance: json["distance"]?.toDouble(),
        drivingSide: drivingSideValues.map[json["driving_side"]]!,
        weight: json["weight"]?.toDouble(),
        mode: modeValues.map[json["mode"]]!,
        geometry: json["geometry"],
    );

    Map<String, dynamic> toJson() => {
        "voiceInstructions": List<dynamic>.from(voiceInstructions.map((x) => x.toJson())),
        "intersections": List<dynamic>.from(intersections.map((x) => x.toJson())),
        "maneuver": maneuver.toJson(),
        "name": name,
        "duration": duration,
        "distance": distance,
        "driving_side": drivingSideValues.reverse[drivingSide],
        "weight": weight,
        "mode": modeValues.reverse[mode],
        "geometry": geometry,
    };
}

enum DrivingSide {
    LEFT,
    RIGHT,
    SLIGHT_RIGHT
}

final drivingSideValues = EnumValues({
    "left": DrivingSide.LEFT,
    "right": DrivingSide.RIGHT,
    "slight right": DrivingSide.SLIGHT_RIGHT
});

class Intersection {
    final List<int> bearings;
    final List<bool> entry;
    final MapboxStreetsV8? mapboxStreetsV8;
    final bool? isUrban;
    final int adminIndex;
    final int? out;
    final int geometryIndex;
    final List<double> location;
    final int? intersectionIn;
    final double? turnWeight;
    final double? turnDuration;
    final double? duration;
    final double? weight;

    Intersection({
        required this.bearings,
        required this.entry,
        this.mapboxStreetsV8,
        this.isUrban,
        required this.adminIndex,
        this.out,
        required this.geometryIndex,
        required this.location,
        this.intersectionIn,
        this.turnWeight,
        this.turnDuration,
        this.duration,
        this.weight,
    });

    factory Intersection.fromRawJson(String str) => Intersection.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Intersection.fromJson(Map<String, dynamic> json) => Intersection(
        bearings: List<int>.from(json["bearings"].map((x) => x)),
        entry: List<bool>.from(json["entry"].map((x) => x)),
        mapboxStreetsV8: json["mapbox_streets_v8"] == null ? null : MapboxStreetsV8.fromJson(json["mapbox_streets_v8"]),
        isUrban: json["is_urban"],
        adminIndex: json["admin_index"],
        out: json["out"],
        geometryIndex: json["geometry_index"],
        location: List<double>.from(json["location"].map((x) => x?.toDouble())),
        intersectionIn: json["in"],
        turnWeight: json["turn_weight"]?.toDouble(),
        turnDuration: json["turn_duration"]?.toDouble(),
        duration: json["duration"]?.toDouble(),
        weight: json["weight"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "bearings": List<dynamic>.from(bearings.map((x) => x)),
        "entry": List<dynamic>.from(entry.map((x) => x)),
        "mapbox_streets_v8": mapboxStreetsV8?.toJson(),
        "is_urban": isUrban,
        "admin_index": adminIndex,
        "out": out,
        "geometry_index": geometryIndex,
        "location": List<dynamic>.from(location.map((x) => x)),
        "in": intersectionIn,
        "turn_weight": turnWeight,
        "turn_duration": turnDuration,
        "duration": duration,
        "weight": weight,
    };
}

class MapboxStreetsV8 {
    final Class mapboxStreetsV8Class;

    MapboxStreetsV8({
        required this.mapboxStreetsV8Class,
    });

    factory MapboxStreetsV8.fromRawJson(String str) => MapboxStreetsV8.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MapboxStreetsV8.fromJson(Map<String, dynamic> json) => MapboxStreetsV8(
        mapboxStreetsV8Class: classValues.map[json["class"]] ?? Class.STREET,
    );

    Map<String, dynamic> toJson() => {
        "class": classValues.reverse[mapboxStreetsV8Class],
    };
}

enum Class {
    SECONDARY,
    STREET,
    TERTIARY
}

final classValues = EnumValues({
    "secondary": Class.SECONDARY,
    "street": Class.STREET,
    "tertiary": Class.TERTIARY
});

class Maneuver {
    final Type type;
    final String instruction;
    final int bearingAfter;
    final int bearingBefore;
    final List<double> location;
    final DrivingSide? modifier;

    Maneuver({
        required this.type,
        required this.instruction,
        required this.bearingAfter,
        required this.bearingBefore,
        required this.location,
        this.modifier,
    });

    factory Maneuver.fromRawJson(String str) => Maneuver.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Maneuver.fromJson(Map<String, dynamic> json) => Maneuver(
        type: typeValues.map[json["type"]] ?? Type.ARRIVE,
        instruction: json["instruction"],
        bearingAfter: json["bearing_after"],
        bearingBefore: json["bearing_before"],
        location: List<double>.from(json["location"].map((x) => x?.toDouble())),
        modifier: drivingSideValues.map[json["modifier"]] ?? DrivingSide.LEFT,
    );

    Map<String, dynamic> toJson() => {
        "type": typeValues.reverse[type],
        "instruction": instruction,
        "bearing_after": bearingAfter,
        "bearing_before": bearingBefore,
        "location": List<dynamic>.from(location.map((x) => x)),
        "modifier": drivingSideValues.reverse[modifier],
    };
}

enum Type {
    ARRIVE,
    DEPART,
    END_OF_ROAD,
    TURN
}

final typeValues = EnumValues({
    "arrive": Type.ARRIVE,
    "depart": Type.DEPART,
    "end of road": Type.END_OF_ROAD,
    "turn": Type.TURN
});

enum Mode {
    DRIVING
}

final modeValues = EnumValues({
    "driving": Mode.DRIVING
});

class VoiceInstruction {
    final String ssmlAnnouncement;
    final String announcement;
    final double distanceAlongGeometry;

    VoiceInstruction({
        required this.ssmlAnnouncement,
        required this.announcement,
        required this.distanceAlongGeometry,
    });

    factory VoiceInstruction.fromRawJson(String str) => VoiceInstruction.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory VoiceInstruction.fromJson(Map<String, dynamic> json) => VoiceInstruction(
        ssmlAnnouncement: json["ssmlAnnouncement"],
        announcement: json["announcement"],
        distanceAlongGeometry: json["distanceAlongGeometry"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "ssmlAnnouncement": ssmlAnnouncement,
        "announcement": announcement,
        "distanceAlongGeometry": distanceAlongGeometry,
    };
}

class Waypoint {
    final double distance;
    final String name;
    final List<double> location;

    Waypoint({
        required this.distance,
        required this.name,
        required this.location,
    });

    factory Waypoint.fromRawJson(String str) => Waypoint.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Waypoint.fromJson(Map<String, dynamic> json) => Waypoint(
        distance: json["distance"]?.toDouble(),
        name: json["name"],
        location: List<double>.from(json["location"].map((x) => x?.toDouble())),
    );

    Map<String, dynamic> toJson() => {
        "distance": distance,
        "name": name,
        "location": List<dynamic>.from(location.map((x) => x)),
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String>? reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap!;
    }
}
