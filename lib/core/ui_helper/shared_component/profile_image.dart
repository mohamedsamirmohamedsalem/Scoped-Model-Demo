import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../constants/endpoints.dart';
import '../../constants/image_constant.dart';

class ProfileImage extends StatefulWidget {
  final String? photoUrl;

  const ProfileImage({super.key, this.photoUrl});

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.white,
      backgroundImage: widget.photoUrl != null && widget.photoUrl!.isNotEmpty
          ? null
          : AssetImage(ImageConstant.profile), // Your fallback asset image
      child: widget.photoUrl != null && widget.photoUrl!.isNotEmpty
          ? ClipOval(
              child: CachedNetworkImage(
                imageUrl: "${Endpoints.imageBaseURL}${widget.photoUrl}",
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => Image.asset(
                  ImageConstant.profile, // Your fallback asset image
                  fit: BoxFit.cover,
                ),
              ),
            )
          : null,
    );
  }
}
