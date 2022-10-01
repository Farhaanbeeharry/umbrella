import 'package:flutter/material.dart';

import '../common/poppins_fonts.dart';
import '../models/weather_model.dart';

class SideNavDayWidget extends StatefulWidget {
  final int index;
  final int listSize;
  final WeatherModel data;
  final void Function(WeatherModel) onClick;
  final void Function(int, WeatherModel) onDelete;

  const SideNavDayWidget(
      {super.key,
      required this.index,
      required this.listSize,
      required this.data,
      required this.onClick,
      required this.onDelete});

  @override
  State<SideNavDayWidget> createState() => _SideNavDayWidgetState();
}

class _SideNavDayWidgetState extends State<SideNavDayWidget> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        setState(() {
          _isHovering = true;
        });
      },
      onExit: (event) {
        setState(() {
          _isHovering = false;
        });
      },
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.1875,
            decoration: widget.data.isSelected
                ? const BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.15))
                : null,
            child: InkWell(
              onTap: () {
                widget.onClick(widget.data);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 11.0, horizontal: 50.0),
                child: Text(
                  'Day ${widget.index + 1}',
                  style: TextStyle(
                    fontFamily: Poppins.regular,
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          if (_isHovering && widget.listSize > 1)
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 11.0, horizontal: 30.0),
                child: InkWell(
                  onTap: () {
                    widget.onDelete(widget.index, widget.data);
                  },
                  child: const Icon(
                    Icons.remove_circle_outline,
                    color: Colors.white,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
