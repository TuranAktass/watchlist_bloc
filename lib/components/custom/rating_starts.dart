import 'package:flutter/material.dart';

class RateStars extends StatefulWidget {
  const RateStars({Key? key, required this.rating}) : super(key: key);
  final String rating;
  @override
  _RateStarsState createState() => _RateStarsState();
}

class _RateStarsState extends State<RateStars> {
  var rating = 0.0;

  @override
  initState() {
    rating = double.tryParse(widget.rating) ?? 0.0;
    rating = rating / 2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return Icon(
                index < rating ? Icons.star : Icons.star_border,
                color: Colors.amber,
              );
            }),
          ),
        ),
        Expanded(
            flex: 4,
            child: Text('${widget.rating} / 10',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.grey)))
      ],
    );
  }
}
