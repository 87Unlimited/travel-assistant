import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomSnackbar {
  static void show(BuildContext context, String message, bool isError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.all(10),
          height: 80,
          decoration: BoxDecoration(
            color: isError ? const Color(0xFFC72C41) : const Color(0xFF3bcce5),
            borderRadius: const BorderRadius.all(Radius.circular(50)),
          ),
          child: Row(
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.5),
                ),
                child: Center(
                  child: Icon(
                    isError ?  FontAwesomeIcons.xmark : FontAwesomeIcons.check,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
              const SizedBox(width: 12,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isError ? "Oh No!" : "Success!",
                      style: const TextStyle(
                          fontSize: 28,
                          color: Colors.white
                      ),
                    ),
                    Text(
                      message,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}
