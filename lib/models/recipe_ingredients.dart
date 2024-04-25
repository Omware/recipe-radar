// To parse this JSON data, do
//
//     final recipeInformation = recipeInformationFromJson(jsonString);

import 'dart:convert';

RecipeInformation recipeInformationFromJson(String str) =>
    RecipeInformation.fromJson(json.decode(str));

String recipeInformationToJson(RecipeInformation data) =>
    json.encode(data.toJson());

class RecipeInformation {
  bool vegetarian;
  bool vegan;
  bool glutenFree;
  bool dairyFree;
  bool veryHealthy;
  bool cheap;
  bool veryPopular;
  bool sustainable;
  bool lowFodmap;
  int weightWatcherSmartPoints;
  String gaps;
  int preparationMinutes;
  int cookingMinutes;
  int aggregateLikes;
  int healthScore;
  String creditsText;
  String sourceName;
  double pricePerServing;
  List<ExtendedIngredient> extendedIngredients;
  int id;
  String title;
  int readyInMinutes;
  int servings;
  String sourceUrl;
  String image;
  String imageType;
  Taste taste;
  String summary;
  List<String> cuisines;
  List<String> dishTypes;
  List<dynamic> diets;
  List<dynamic> occasions;
  WinePairing winePairing;
  dynamic instructions;
  List<dynamic> analyzedInstructions;
  dynamic originalId;
  double spoonacularScore;

  RecipeInformation({
    required this.vegetarian,
    required this.vegan,
    required this.glutenFree,
    required this.dairyFree,
    required this.veryHealthy,
    required this.cheap,
    required this.veryPopular,
    required this.sustainable,
    required this.lowFodmap,
    required this.weightWatcherSmartPoints,
    required this.gaps,
    required this.preparationMinutes,
    required this.cookingMinutes,
    required this.aggregateLikes,
    required this.healthScore,
    required this.creditsText,
    required this.sourceName,
    required this.pricePerServing,
    required this.extendedIngredients,
    required this.id,
    required this.title,
    required this.readyInMinutes,
    required this.servings,
    required this.sourceUrl,
    required this.image,
    required this.imageType,
    required this.taste,
    required this.summary,
    required this.cuisines,
    required this.dishTypes,
    required this.diets,
    required this.occasions,
    required this.winePairing,
    required this.instructions,
    required this.analyzedInstructions,
    required this.originalId,
    required this.spoonacularScore,
  });

  factory RecipeInformation.fromJson(Map<String, dynamic> json) =>
      RecipeInformation(
        vegetarian: json["vegetarian"],
        vegan: json["vegan"],
        glutenFree: json["glutenFree"],
        dairyFree: json["dairyFree"],
        veryHealthy: json["veryHealthy"],
        cheap: json["cheap"],
        veryPopular: json["veryPopular"],
        sustainable: json["sustainable"],
        lowFodmap: json["lowFodmap"],
        weightWatcherSmartPoints: json["weightWatcherSmartPoints"],
        gaps: json["gaps"],
        preparationMinutes: json["preparationMinutes"],
        cookingMinutes: json["cookingMinutes"],
        aggregateLikes: json["aggregateLikes"],
        healthScore: json["healthScore"],
        creditsText: json["creditsText"],
        sourceName: json["sourceName"],
        pricePerServing: json["pricePerServing"]?.toDouble(),
        extendedIngredients: List<ExtendedIngredient>.from(
            json["extendedIngredients"]
                .map((x) => ExtendedIngredient.fromJson(x))),
        id: json["id"],
        title: json["title"],
        readyInMinutes: json["readyInMinutes"],
        servings: json["servings"],
        sourceUrl: json["sourceUrl"],
        image: json["image"],
        imageType: json["imageType"],
        taste: Taste.fromJson(json["taste"]),
        summary: json["summary"],
        cuisines: List<String>.from(json["cuisines"].map((x) => x)),
        dishTypes: List<String>.from(json["dishTypes"].map((x) => x)),
        diets: List<dynamic>.from(json["diets"].map((x) => x)),
        occasions: List<dynamic>.from(json["occasions"].map((x) => x)),
        winePairing: WinePairing.fromJson(json["winePairing"]),
        instructions: json["instructions"],
        analyzedInstructions:
            List<dynamic>.from(json["analyzedInstructions"].map((x) => x)),
        originalId: json["originalId"],
        spoonacularScore: json["spoonacularScore"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "vegetarian": vegetarian,
        "vegan": vegan,
        "glutenFree": glutenFree,
        "dairyFree": dairyFree,
        "veryHealthy": veryHealthy,
        "cheap": cheap,
        "veryPopular": veryPopular,
        "sustainable": sustainable,
        "lowFodmap": lowFodmap,
        "weightWatcherSmartPoints": weightWatcherSmartPoints,
        "gaps": gaps,
        "preparationMinutes": preparationMinutes,
        "cookingMinutes": cookingMinutes,
        "aggregateLikes": aggregateLikes,
        "healthScore": healthScore,
        "creditsText": creditsText,
        "sourceName": sourceName,
        "pricePerServing": pricePerServing,
        "extendedIngredients":
            List<dynamic>.from(extendedIngredients.map((x) => x.toJson())),
        "id": id,
        "title": title,
        "readyInMinutes": readyInMinutes,
        "servings": servings,
        "sourceUrl": sourceUrl,
        "image": image,
        "imageType": imageType,
        "taste": taste.toJson(),
        "summary": summary,
        "cuisines": List<dynamic>.from(cuisines.map((x) => x)),
        "dishTypes": List<dynamic>.from(dishTypes.map((x) => x)),
        "diets": List<dynamic>.from(diets.map((x) => x)),
        "occasions": List<dynamic>.from(occasions.map((x) => x)),
        "winePairing": winePairing.toJson(),
        "instructions": instructions,
        "analyzedInstructions":
            List<dynamic>.from(analyzedInstructions.map((x) => x)),
        "originalId": originalId,
        "spoonacularScore": spoonacularScore,
      };
}

class ExtendedIngredient {
  int id;
  String? aisle;
  String image;
  Consistency consistency;
  String name;
  String nameClean;
  String original;
  String originalName;
  double amount;
  String unit;
  List<String> meta;
  Measures measures;

  ExtendedIngredient({
    required this.id,
    required this.aisle,
    required this.image,
    required this.consistency,
    required this.name,
    required this.nameClean,
    required this.original,
    required this.originalName,
    required this.amount,
    required this.unit,
    required this.meta,
    required this.measures,
  });

  factory ExtendedIngredient.fromJson(Map<String, dynamic> json) =>
      ExtendedIngredient(
        id: json["id"],
        aisle: json["aisle"],
        image: json["image"],
        consistency: consistencyValues.map[json["consistency"]]!,
        name: json["name"],
        nameClean: json["nameClean"],
        original: json["original"],
        originalName: json["originalName"],
        amount: json["amount"]?.toDouble(),
        unit: json["unit"],
        meta: List<String>.from(json["meta"].map((x) => x)),
        measures: Measures.fromJson(json["measures"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "aisle": aisle,
        "image": image,
        "consistency": consistencyValues.reverse[consistency],
        "name": name,
        "nameClean": nameClean,
        "original": original,
        "originalName": originalName,
        "amount": amount,
        "unit": unit,
        "meta": List<dynamic>.from(meta.map((x) => x)),
        "measures": measures.toJson(),
      };
}

enum Consistency { LIQUID, SOLID }

final consistencyValues =
    EnumValues({"LIQUID": Consistency.LIQUID, "SOLID": Consistency.SOLID});

class Measures {
  Metric us;
  Metric metric;

  Measures({
    required this.us,
    required this.metric,
  });

  factory Measures.fromJson(Map<String, dynamic> json) => Measures(
        us: Metric.fromJson(json["us"]),
        metric: Metric.fromJson(json["metric"]),
      );

  Map<String, dynamic> toJson() => {
        "us": us.toJson(),
        "metric": metric.toJson(),
      };
}

class Metric {
  double amount;
  String unitShort;
  String unitLong;

  Metric({
    required this.amount,
    required this.unitShort,
    required this.unitLong,
  });

  factory Metric.fromJson(Map<String, dynamic> json) => Metric(
        amount: json["amount"]?.toDouble(),
        unitShort: json["unitShort"],
        unitLong: json["unitLong"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "unitShort": unitShort,
        "unitLong": unitLong,
      };
}

class Taste {
  double sweetness;
  int saltiness;
  double sourness;
  double bitterness;
  double savoriness;
  double fattiness;
  int spiciness;

  Taste({
    required this.sweetness,
    required this.saltiness,
    required this.sourness,
    required this.bitterness,
    required this.savoriness,
    required this.fattiness,
    required this.spiciness,
  });

  factory Taste.fromJson(Map<String, dynamic> json) => Taste(
        sweetness: json["sweetness"]?.toDouble(),
        saltiness: json["saltiness"],
        sourness: json["sourness"]?.toDouble(),
        bitterness: json["bitterness"]?.toDouble(),
        savoriness: json["savoriness"]?.toDouble(),
        fattiness: json["fattiness"]?.toDouble(),
        spiciness: json["spiciness"],
      );

  Map<String, dynamic> toJson() => {
        "sweetness": sweetness,
        "saltiness": saltiness,
        "sourness": sourness,
        "bitterness": bitterness,
        "savoriness": savoriness,
        "fattiness": fattiness,
        "spiciness": spiciness,
      };
}

class WinePairing {
  WinePairing();

  factory WinePairing.fromJson(Map<String, dynamic> json) => WinePairing();

  Map<String, dynamic> toJson() => {};
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
