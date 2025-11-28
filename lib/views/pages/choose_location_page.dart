import 'package:counter/models/location_model.dart';
import 'package:counter/utlis/app_color.dart';
import 'package:flutter/material.dart';
import 'package:hash_cached_image/hash_cached_image.dart';

class ChooseLocationPage extends StatelessWidget {
  const ChooseLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Address"))),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Choose your location",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "let's find an unforgettable event. Choose a location below to get started",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.grey,
                    //fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 36),
                TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade400,
                    filled: true,
                    prefixIcon: Icon(Icons.location_on),
                    prefixIconColor: AppColors.greyShade,
                    hintText: "Write your Location",
                    hintStyle: TextStyle(color: AppColors.greyShade),

                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.my_location),
                    ),
                    suffixIconColor: AppColors.greyShade,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 36),
                Text(
                  "Select Location",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  dummyLocations[index].city,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium!.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${dummyLocations[index].city} ,${dummyLocations[index].country} ",
                                  style: Theme.of(context).textTheme.bodyMedium!
                                      .copyWith(color: AppColors.grey),
                                ),
                              ],
                            ),
                            CircleAvatar(
                              backgroundImage: HashCachedImageProvider(dummyLocations[index].imgUrl),
                            ),
                            HashCachedImage(
                              imageUrl: dummyLocations[index].imgUrl,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: dummyLocations.length,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                    ),
                    onPressed: () {},
                    child: Text("Confirm"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
