import 'package:flutter/material.dart';

class Timeline extends StatefulWidget {
  final List<Widget> children;
  final double itemGap;
  final List<Widget> indicators;

  final Color lineColor;
  final double lineGap;
  final double indicatorSize;
  final Color indicatorColor;
  final PaintingStyle indicatorStyle;
  final StrokeCap strokeCap;
  final double strokeWidth;
  final PaintingStyle style;

  const Timeline({
    @required this.children,
    this.indicators,
    this.itemGap = 12.0,
    this.indicatorSize = 20,
    this.lineColor = Colors.grey,
    this.lineGap = 4.0,
    this.indicatorColor = Colors.blue,
    this.indicatorStyle = PaintingStyle.stroke,
    this.strokeCap = StrokeCap.butt,
    this.strokeWidth = 1.0,
    this.style = PaintingStyle.stroke,
  }) :  assert(itemGap >= 0),
        assert(lineGap >= 0),
        assert(indicators == null || children.length == indicators.length);

  @override
  TimelineState createState() => TimelineState();

}

class TimelineState extends State<Timeline> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }
  @override
  Widget build(BuildContext context) {
     return ListView.separated(
       separatorBuilder: (_, __) => SizedBox(height: widget.itemGap),
       physics: AlwaysScrollableScrollPhysics(),
       scrollDirection: Axis.vertical,
       shrinkWrap: true,
       itemCount: widget.indicators.length,
       controller: _scrollController,
       itemBuilder: (context, index) {
         final child = widget.children[index];

         Widget indicator;
         if (widget.indicators != null) {
           indicator = widget.indicators[index];
         }

         final isFirst = index == 0;
         final isLast = index == widget.indicators.length - 1;

         final timelineTile = <Widget>[
           Container(
             margin: EdgeInsets.only(left: 7),
             child: CustomPaint(
               foregroundPainter: _TimelinePainter(
                 lineColor: widget.lineColor,
                 indicatorColor: widget.indicatorColor,
                 indicatorSize: widget.indicatorSize,
                 indicatorStyle: widget.indicatorStyle,
                 isFirst: isFirst,
                 isLast: isLast,
                 lineGap: widget.lineGap,
                 strokeCap: widget.strokeCap,
                 strokeWidth: widget.strokeWidth,
                 style: widget.style,
                 itemGap: widget.itemGap,
               ),
               child: SizedBox(
                 height: double.infinity,
                 child: indicator,
               ),
             ),
           ),
           SizedBox(width: 18),
           Expanded(
               child: child
           ),
         ];

         return IntrinsicHeight(
           child: Row(
             mainAxisAlignment: MainAxisAlignment.start,
             children: timelineTile,
           ),
         );
         },
    );
  }
}

class _TimelinePainter extends CustomPainter {
  _TimelinePainter({
    @required this.indicatorColor,
    @required this.indicatorStyle,
    @required this.indicatorSize,
    @required this.lineGap,
    @required this.strokeCap,
    @required this.strokeWidth,
    @required this.style,
    @required this.lineColor,
    @required this.isFirst,
    @required this.isLast,
    @required this.itemGap,
  })  : linePaint = Paint()
    ..color = lineColor
    ..strokeCap = strokeCap
    ..strokeWidth = strokeWidth
    ..style = style,
        circlePaint = Paint()
          ..color = indicatorColor
          ..style = indicatorStyle;

  final Color indicatorColor;
  final PaintingStyle indicatorStyle;
  final double indicatorSize;
  final double lineGap;
  final StrokeCap strokeCap;
  final double strokeWidth;
  final PaintingStyle style;
  final Color lineColor;
  final Paint linePaint;
  final Paint circlePaint;
  final bool isFirst;
  final bool isLast;
  final double itemGap;

  @override
  void paint(Canvas canvas, Size size) {
    final indicatorRadius = indicatorSize / 1.25;
    double dashWidth = 9, dashSpace = 6, startY = 0;

    if (!isLast) {
      while(startY < size.height ) {
        canvas.drawLine(
            Offset(indicatorRadius, startY),
            Offset(indicatorRadius, startY + dashWidth) , linePaint
        );
        startY += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
