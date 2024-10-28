import 'package:flutter/material.dart';
import 'package:user_taxi_app/assistants/request_assistant.dart';
import 'package:user_taxi_app/global/map_key.dart';
import 'package:user_taxi_app/models/predicted_places.dart';

class SearchPlacesSceen extends StatefulWidget {

  @override
  State<SearchPlacesSceen> createState() => _SearchPlacesSceenState();
}


class _SearchPlacesSceenState extends State<SearchPlacesSceen> {

  List<PredictedPlaces> placePredictedList = [];

  void findPlaceAutoCompleteSearch(String inputText) async
  {

    if(inputText.length > 1)
    {

      String urlAutoCompleteSearch = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$inputText&key=$mapKey&components=country:yourCountry:CA";

      var responseAutoCompleteSearch =await RequestAssistant.receiveRequest(urlAutoCompleteSearch);

      if(responseAutoCompleteSearch =="Error Occurred, Failed. No Response."){
        return;
      }
      
      if(responseAutoCompleteSearch["status"]=="Ok"){
        var placePredictions = responseAutoCompleteSearch["predictions"];
        var placePredictionsList =  (placePredictions as List).map((jsonData)=>PredictedPlaces.fromJason(jsonData)).toList();
        placePredictedList = placePredictionsList;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        children: [
          Container(height: 160,
          decoration: const BoxDecoration(
            color: Colors.white54,
            boxShadow: [
              BoxShadow(
                color: Colors.white54,
                blurRadius: 8,
                spreadRadius: 0.5,
                offset: Offset(0.7, 0.7),
              )
            ]
          ),

            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const SizedBox(height: 25.0,),


                  Stack(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.grey,
                        ),
                      ),
                      const Center(
                        child: Text(
                          "Search and set dropOff Location",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey,
                            fontWeight:FontWeight.bold,

                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),

                  Row(
                    children: [
                      Icon(
                        Icons.adjust_sharp,
                        color: Colors.grey,

                      ),

                      const SizedBox(width: 18.0,),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            onChanged: (valueTyped)
                            {
                              findPlaceAutoCompleteSearch(valueTyped);

                            },
                            decoration: const InputDecoration(
                              hintText: "search here ...",
                              fillColor: Colors.white54,
                              filled: true,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                left: 11.0,
                                top: 8.0,
                                bottom: 8.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),


        ],
      ),
    );

  }
}
