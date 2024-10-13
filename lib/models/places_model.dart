import 'dart:convert';

class PlacesResponse {
    final String type;
    //final List<String> query;
    final List<Feature> features;
    final String attribution;

    PlacesResponse({
        required this.type,
        //required this.query,
        required this.features,
        required this.attribution,
    });

    factory PlacesResponse.fromRawJson(String str) => PlacesResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PlacesResponse.fromJson(Map<String, dynamic> json) => PlacesResponse(
        type: json["type"] ?? '',
        //query: List<String>.from(json["query"].map((x) => x)),
        features: json["features"] != null ? List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))) : [],
        attribution: json["attribution"] ?? '',
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
        "attribution": attribution,
    };
}

class Feature {
    final String type;
    final String id;
    final Geometry geometry;
    final Properties properties;

    Feature({
        required this.type,
        required this.id,
        required this.geometry,
        required this.properties,
    });

    factory Feature.fromRawJson(String str) => Feature.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        type: json["type"],
        id: json["id"],
        geometry: Geometry.fromJson(json["geometry"]),
        properties: Properties.fromJson(json["properties"]),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "geometry": geometry.toJson(),
        "properties": properties.toJson(),
    };

  @override
  String toString() {
    return 'Feature: ${properties.name}';
  }
}

class Geometry {
    final String type;
    final List<double> coordinates;

    Geometry({
        required this.type,
        required this.coordinates,
    });

    factory Geometry.fromRawJson(String str) => Geometry.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type: json["type"],
        coordinates: List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
    };
}

class Properties {
    final String mapboxId;
    final String featureType;
    final String fullAddress;
    final String name;
    final String namePreferred;
    final Coordinates coordinates;
    final String placeFormatted;
    final List<double> bbox;
    final Context context;

    Properties({
        required this.mapboxId,
        required this.featureType,
        required this.fullAddress,
        required this.name,
        required this.namePreferred,
        required this.coordinates,
        required this.placeFormatted,
        required this.bbox,
        required this.context,
    });

    factory Properties.fromRawJson(String str) => Properties.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        mapboxId: json["mapbox_id"],
        featureType: json["feature_type"],
        fullAddress: json["full_address"],
        name: json["name"],
        namePreferred: json["name_preferred"],
        coordinates: Coordinates.fromJson(json["coordinates"]),
        placeFormatted: json["place_formatted"] ?? "",
        bbox: json["bbox"] != null ? List<double>.from(json["bbox"].map((x) => x?.toDouble())) : [],
        context: Context.fromJson(json["context"]),
    );

    Map<String, dynamic> toJson() => {
        "mapbox_id": mapboxId,
        "feature_type": featureType,
        "full_address": fullAddress,
        "name": name,
        "name_preferred": namePreferred,
        "coordinates": coordinates.toJson(),
        "place_formatted": placeFormatted,
        "bbox": List<dynamic>.from(bbox.map((x) => x)),
        "context": context.toJson(),
    };
}

class Context {
    final Region region;
    final Country country;
    final Place place;
    final Place? locality;
    final Postcode? postcode;
    final Place? district;
    final Place? neighborhood;

    Context({
        required this.region,
        required this.country,
        required this.place,
        this.locality,
        this.postcode,
        this.district,
        this.neighborhood,
    });

    factory Context.fromRawJson(String str) => Context.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Context.fromJson(Map<String, dynamic> json) => Context(
        region: json["region"] != null ? Region.fromJson(json["region"]) : Region(mapboxId: '', name: '', regionCode: '', regionCodeFull: '', translations: Translations(es: En(language: Language.ES, name: ''), en: En(language: Language.EN, name: '')), wikidataId: ''),
        country: Country.fromJson(json["country"]),
        place: json["place"] != null ? Place.fromJson(json["place"]) : Place(mapboxId: '', name: '', translations: Translations(es: En(language: Language.ES, name: ''), en: En(language: Language.EN, name: ''))),
        locality: json["locality"] == null ? null : Place.fromJson(json["locality"]),
        postcode: json["postcode"] == null ? null : Postcode.fromJson(json["postcode"]),
        district: json["district"] == null ? null : Place.fromJson(json["district"]),
        neighborhood: json["neighborhood"] == null ? null : Place.fromJson(json["neighborhood"]),
    );

    Map<String, dynamic> toJson() => {
        "region": region.toJson(),
        "country": country.toJson(),
        "place": place.toJson(),
        "locality": locality?.toJson(),
        "postcode": postcode?.toJson(),
        "district": district?.toJson(),
        "neighborhood": neighborhood?.toJson(),
    };
}

class Country {
    final String mapboxId;
    final String name;
    final String wikidataId;
    final String countryCode;
    final String countryCodeAlpha3;
    final Translations translations;

    Country({
        required this.mapboxId,
        required this.name,
        required this.wikidataId,
        required this.countryCode,
        required this.countryCodeAlpha3,
        required this.translations,
    });

    factory Country.fromRawJson(String str) => Country.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Country.fromJson(Map<String, dynamic> json) => Country(
        mapboxId: json["mapbox_id"],
        name: json["name"],
        wikidataId: json["wikidata_id"],
        countryCode: json["country_code"],
        countryCodeAlpha3: json["country_code_alpha_3"],
        translations: Translations.fromJson(json["translations"]),
    );

    Map<String, dynamic> toJson() => {
        "mapbox_id": mapboxId,
        "name": name,
        "wikidata_id": wikidataId,
        "country_code": countryCode,
        "country_code_alpha_3": countryCodeAlpha3,
        "translations": translations.toJson(),
    };
}

class Translations {
    final En es;
    final En en;

    Translations({
        required this.es,
        required this.en,
    });

    factory Translations.fromRawJson(String str) => Translations.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Translations.fromJson(Map<String, dynamic> json) => Translations(
        es: En.fromJson(json["es"]),
        en: En.fromJson(json["en"]),
    );

    Map<String, dynamic> toJson() => {
        "es": es.toJson(),
        "en": en.toJson(),
    };
}

class En {
    final Language language;
    final String name;

    En({
        required this.language,
        required this.name,
    });

    factory En.fromRawJson(String str) => En.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory En.fromJson(Map<String, dynamic> json) => En(
        language: languageValues.map[json["language"]]!,
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "language": languageValues.reverse[language],
        "name": name,
    };
}

enum Language {
    EN,
    ES,
    NL
}

final languageValues = EnumValues({
    "en": Language.EN,
    "es": Language.ES,
    "nl": Language.NL
});

class Place {
    final String mapboxId;
    final String name;
    final String? wikidataId;
    final Translations translations;
    final Place? alternate;

    Place({
        required this.mapboxId,
        required this.name,
        this.wikidataId,
        required this.translations,
        this.alternate,
    });

    factory Place.fromRawJson(String str) => Place.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Place.fromJson(Map<String, dynamic> json) => Place(
        mapboxId: json["mapbox_id"],
        name: json["name"],
        wikidataId: json["wikidata_id"],
        translations: Translations.fromJson(json["translations"]),
        alternate: json["alternate"] == null ? null : Place.fromJson(json["alternate"]),
    );

    Map<String, dynamic> toJson() => {
        "mapbox_id": mapboxId,
        "name": name,
        "wikidata_id": wikidataId,
        "translations": translations.toJson(),
        "alternate": alternate?.toJson(),
    };
}

class Postcode {
    final String mapboxId;
    final String name;

    Postcode({
        required this.mapboxId,
        required this.name,
    });

    factory Postcode.fromRawJson(String str) => Postcode.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Postcode.fromJson(Map<String, dynamic> json) => Postcode(
        mapboxId: json["mapbox_id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "mapbox_id": mapboxId,
        "name": name,
    };
}

class Region {
    final String mapboxId;
    final String name;
    final String wikidataId;
    final String regionCode;
    final String regionCodeFull;
    final Translations translations;

    Region({
        required this.mapboxId,
        required this.name,
        required this.wikidataId,
        required this.regionCode,
        required this.regionCodeFull,
        required this.translations,
    });

    factory Region.fromRawJson(String str) => Region.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Region.fromJson(Map<String, dynamic> json) => Region(
        mapboxId: json["mapbox_id"],
        name: json["name"],
        wikidataId: json["wikidata_id"],
        regionCode: json["region_code"] ?? '',
        regionCodeFull: json["region_code_full"] ?? '',
        translations: Translations.fromJson(json["translations"]),
    );

    Map<String, dynamic> toJson() => {
        "mapbox_id": mapboxId,
        "name": name,
        "wikidata_id": wikidataId,
        "region_code": regionCode,
        "region_code_full": regionCodeFull,
        "translations": translations.toJson(),
    };
}

class Coordinates {
    final double longitude;
    final double latitude;

    Coordinates({
        required this.longitude,
        required this.latitude,
    });

    factory Coordinates.fromRawJson(String str) => Coordinates.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        longitude: json["longitude"]?.toDouble(),
        latitude: json["latitude"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "longitude": longitude,
        "latitude": latitude,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
