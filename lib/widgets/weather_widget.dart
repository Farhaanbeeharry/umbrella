import 'package:flutter/material.dart';
import 'package:umbrella/common/poppins_fonts.dart';

class WeatherWidget extends StatefulWidget {
  final String selected;
  final String id;
  final String timeOfTheDay;
  final String label;
  final void Function(String, String, String) onClick;

  const WeatherWidget(
      {super.key,
      required this.id,
      required this.timeOfTheDay,
      required this.label,
      required this.selected,
      required this.onClick});

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onClick(widget.id, widget.timeOfTheDay, widget.label);
      },
      child: MouseRegion(
        onHover: (event) {
          setState(() {
            _isHovering = true;
          });
        },
        onExit: (event) {
          _isHovering = false;
        },
        child: AnimatedContainer(
          width: MediaQuery.of(context).size.width * 0.08,
          height: MediaQuery.of(context).size.height * 0.17,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(
                10.0,
              ),
            ),
            border: _isHovering
                ? (widget.selected == widget.label
                    ? Border.all(color: Colors.white)
                    : Border.all(color: Colors.white30))
                : (widget.selected == widget.label
                    ? Border.all(color: Colors.white)
                    : null),
            color: _isHovering
                ? (widget.selected == widget.label
                    ? const Color.fromRGBO(217, 217, 217, 0.05)
                    : const Color.fromRGBO(150, 150, 150, 0.03))
                : (widget.selected == widget.label
                    ? const Color.fromRGBO(217, 217, 217, 0.05)
                    : null),
          ),
          duration: const Duration(milliseconds: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/weather/${widget.label}.png",
                width: MediaQuery.of(context).size.width * 0.035,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                widget.label,
                style: TextStyle(
                  fontFamily: Poppins.regular,
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
