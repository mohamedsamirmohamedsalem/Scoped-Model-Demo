import 'package:scoped_model_demo/core/logic_helper/import_all.dart';

class CustomDarkButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const CustomDarkButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.backgroundColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.infinityWidth,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.only(left: 10, right: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

class CustomLightButton extends StatelessWidget {
  final String text;

  final VoidCallback onPressed;

  const CustomLightButton(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.white, // Text color
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
    );
  }
}

class CustomTransparentButton extends StatelessWidget {
  final String text;
  final Color foregroundColor;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const CustomTransparentButton(
      {super.key,
      required this.text,
      this.foregroundColor = Colors.white,
      this.backgroundColor = Colors.transparent,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor, // Text color
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: foregroundColor),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}

class CustomImageButton extends StatelessWidget {
  final String image;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const CustomImageButton(
      {super.key,
      required this.image,
      this.backgroundColor = Colors.white,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor, // Text color
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: GestureDetector(
            onTap: onPressed, child: CustomImageView(imagePath: image)),
      ),
    );
  }
}
