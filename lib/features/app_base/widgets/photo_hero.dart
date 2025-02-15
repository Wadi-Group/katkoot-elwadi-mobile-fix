import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:katkoot_elwady/features/messages_management/models/message.dart';
import 'package:katkoot_elwady/features/menu_management/screens/image_viewer.dart';

class PhotoHero extends StatelessWidget {
  final Message message;
  const PhotoHero({required this.message});

  Widget build(BuildContext context) {
    return SizedBox(
      child: Hero(
        tag: message.attachment!,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              //timeDilation = 1.0;

              Navigator.of(context).push(MaterialPageRoute<void>(
                  builder: (context) => ImageViewer(
                        imagePath: message.attachment!,
                      )));
            },
            child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        message.attachment ?? "",
                      ),
                      fit: BoxFit.contain),
                  color: Colors.transparent,
                  // borderRadius: BorderRadius.circular(25)
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 4),
          ),
        ),
      ),
    );
  }
}
