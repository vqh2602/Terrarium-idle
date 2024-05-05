import 'package:terrarium_idle/data/local/user.dart';

Map<String, dynamic> data = {
  "user": {
    "userID": "",
    "userEmail": "",
    "userName": "",
    "userAvatar": "",
    "userLevelEXP": 0,
    "userLevel": 0,
    "userTotalLike": 0,
    "userFloor": 3,
    "identifier": "ee", // gói đăng kí 1_month , 1_year
    "latestPurchaseDate": 12432545, // ngàY CÒN DỊCH VỤ ( NGÀY MUA MỚI NHẤT)
  },
  "money": {
    "oxygen": 1000,
    "gemstone": 1000,
    "ticket": 1000,
  },
  "item": {
    "fertilizer": 0,
    "shovel": 0,
  },
  "cart": {
    "cartPlants": ["p1", "p2", "p3"],
    "cartPots": ["p11", "p22", "p33"],
  },
  "plants": [
    {
      "idPlant": "p1",
      "idPot": "p11",
      "position": "1,1",
      "harvest time": 127647634876,
      "platLevelExp": 1234,
      "plantLevel": 1,
    },
    {
      "idPlant": "p1",
      "idPot": "p11",
      "position": "1,2",
      "harvest time": 127647634876,
      "platLevelExp": 1234,
      "plantLevel": 1,
    },
    {
      "idPlant": "p1",
      "idPot": "p11",
      "position": "1,3",
      "harvest time": 127647634876,
      "platLevelExp": 1234,
      "plantLevel": 1,
    },
    {
      "idPlant": "p1",
      "idPot": "p11",
      "position": "2,2",
      "harvest time": 127647634876,
      "platLevelExp": 1234,
      "plantLevel": 1,
    }
  ]
};
UserData dataTest = UserData.fromMap(data);
