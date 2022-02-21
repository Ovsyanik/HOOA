import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Step, StepState, StepperType;
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/widget/Button.dart';
export 'package:flutter/material.dart' show Step, StepState, StepperType;

const double _kLineWidth = 1.0;
const double _kStepSize = 44.0;
const double _kStepMargin = 24.0;
const double _kStepPadding = 8.0;
const double _kStepSpacing = 12.0;
const double _kStepFontSize = 20.0;
const double _kTriangleHeight =
    _kStepSize * 0.866025; // Triangle height. sqrt(3.0) / 2.0
const Duration _kThemeAnimationDuration = const Duration(milliseconds: 200);

class CupertinoStepper extends StatefulWidget {
  const CupertinoStepper({
    @required this.buttonText,
    this.steps,
    this.physics,
    this.currentStep = 0,
    this.onStepTapped,
    this.onButtonPressed,
  }) : assert(0 <= currentStep && currentStep < steps.length);

  final List<Step> steps;
  final List<String> buttonText;

  final ScrollPhysics physics;

  final int currentStep;

  final ValueChanged<int> onStepTapped;

  final List<VoidCallback> onButtonPressed;

  @override
  _CupertinoStepperState createState() => _CupertinoStepperState();
}

class _CupertinoStepperState extends State<CupertinoStepper>
    with TickerProviderStateMixin {
  final Map<int, StepState> _oldStates = <int, StepState>{};

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < widget.steps.length; i += 1)
      _oldStates[i] = widget.steps[i].state;
  }

  @override
  void didUpdateWidget(CupertinoStepper oldWidget) {
    super.didUpdateWidget(oldWidget);
    assert(widget.steps.length == oldWidget.steps.length);

    for (int i = 0; i < oldWidget.steps.length; i += 1)
      _oldStates[i] = oldWidget.steps[i].state;
  }


  bool _isLast(int index) {
    return widget.steps.length - 1 == index;
  }

  bool _isCurrent(int index) {
    return widget.currentStep == index;
  }

  Widget _buildLine(bool visible) {
    return Container(
      width: visible ? _kLineWidth : 0.0,
      height: 16.0,
      color: CupertinoColors.separator,
    );
  }

  Color _circleColor(int index) {
    final CupertinoThemeData themeData = CupertinoTheme.of(context);
    return widget.steps[index].isActive ? themeData.primaryColor : null;
  }

  Color _borderColor(int index) {
    final CupertinoThemeData themeData = CupertinoTheme.of(context);
    return widget.steps[index].state == StepState.disabled
        ? CupertinoDynamicColor.resolve(
            CupertinoColors.placeholderText, context)
        : themeData.primaryColor;
  }

  Widget _buildCircle(int index, bool oldState) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: _kStepPadding),
      width: _kStepSize,
      height: _kStepSize,
      child: AnimatedContainer(
        curve: Curves.fastOutSlowIn,
        duration: _kThemeAnimationDuration,
        decoration: ShapeDecoration(
          color: _circleColor(index),
          shape: CircleBorder(side: BorderSide(color: _borderColor(index))),
        ),
        child: Center(
          child: _buildCircleChild(
              index, oldState && widget.steps[index].state == StepState.error),
        ),
      ),
    );
  }

  Widget _buildCircleChild(int index, bool oldState) {
    final CupertinoThemeData themeData = CupertinoTheme.of(context);
    final StepState state =
        oldState ? _oldStates[index] : widget.steps[index].state;
    final bool isActive = widget.steps[index].isActive;
    switch (state) {
      case StepState.disabled:
      case StepState.indexed:
        return Text(
          '${index + 1}',
          style: TextStyle(
            fontSize: _kStepFontSize,
            color: isActive
                ? CupertinoDynamicColor.resolve(CupertinoColors.white, context)
                : state == StepState.disabled
                    ? CupertinoDynamicColor.resolve(
                        CupertinoColors.placeholderText, context)
                    : themeData.primaryColor,
          ),
        );
      case StepState.editing:
        return Icon(
          CupertinoIcons.pencil,
          color: isActive
              ? CupertinoDynamicColor.resolve(CupertinoColors.white, context)
              : themeData.primaryColor,
          size: _kStepFontSize,
        );
      case StepState.complete:
        return Icon(
          CupertinoIcons.check_mark,
          color: isActive
              ? CupertinoDynamicColor.resolve(CupertinoColors.white, context)
              : themeData.primaryColor,
          size: _kStepFontSize * 2,
        );
      case StepState.error:
        return const Text(
          '!',
          style: TextStyle(
            fontSize: _kStepFontSize,
            color: CupertinoColors.white,
          ),
        );
    }
  }

  Widget _buildTriangle(int index, bool oldState) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: _kStepPadding),
      width: _kStepSize,
      height: _kStepSize,
      child: Center(
        child: SizedBox(
          width: _kStepSize,
          height:
              _kTriangleHeight, // Height of 24dp-long-sided equilateral triangle.
          child: CustomPaint(
            painter: _TrianglePainter(
              color: CupertinoDynamicColor.resolve(
                  CupertinoColors.systemRed, context),
            ),
            child: Align(
              alignment: const Alignment(
                  0.0, 0.8), // 0.8 looks better than the geometrical 0.33.
              child: _buildCircleChild(index,
                  oldState && widget.steps[index].state != StepState.error),
            ),
          ),
        ),
      ),
    );
  }

  TextStyle _titleStyle(int index) {
    final CupertinoThemeData themeData = CupertinoTheme.of(context);
    final CupertinoTextThemeData textTheme = themeData.textTheme;

    switch (widget.steps[index].state) {
      case StepState.indexed:
      case StepState.editing:
      case StepState.complete:
        return textTheme.navActionTextStyle;
      case StepState.disabled:
        return textTheme.navActionTextStyle.copyWith(
            color: CupertinoDynamicColor.resolve(
                CupertinoColors.placeholderText, context));
      case StepState.error:
        return textTheme.navActionTextStyle.copyWith(
            color: CupertinoDynamicColor.resolve(
                CupertinoColors.systemRed, context));
    }
  }

  Widget _buildHeaderText(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AnimatedDefaultTextStyle(
          style: _titleStyle(index),
          duration: _kThemeAnimationDuration,
          curve: Curves.fastOutSlowIn,
          child: widget.steps[index].title,
        ),
      ],
    );
  }

  Widget _buildHorizontal() {
    final List<Widget> children = <Widget>[
      for (int i = 0; i < widget.steps.length; i += 1) ...<Widget>[
        Focus(
          canRequestFocus: widget.steps[i].state != StepState.disabled,
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: widget.steps[i].state != StepState.disabled
                ? () {
                    if (widget.onStepTapped != null) widget.onStepTapped(i);
                  }
                : null,
            child: Row(
              children: <Widget>[
                Container(
                  child: _buildHeaderText(i),
                ),
              ],
            ),
          ),
        ),
        if (!_isLast(i))
          Expanded(
            child: Container(
              height: _kLineWidth,
              color: CupertinoColors.separator,
            ),
          ),
      ],
    ];

    return Column(
      children: <Widget>[
        Container(
          child: Row(
            children: children,
          ),
        ),
        Expanded(
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: <Widget>[
              widget.steps[widget.currentStep].content,
              Button(
                color: HexColor('#FF844B'),
                text: widget.buttonText[widget.currentStep],
                onPressed: widget.onButtonPressed[widget.currentStep],
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasDirectionality(context));
    assert(() {
      if (context.findAncestorWidgetOfExactType<CupertinoStepper>() != null)
        throw FlutterError('Steppers must not be nested.\n'
            'The material specification advises that one should avoid embedding '
            'steppers within steppers. '
            'https://material.io/archive/guidelines/components/steppers.html#steppers-usage');
      return true;
    }());
    return _buildHorizontal();
  }
}

// Paints a triangle whose base is the bottom of the bounding rectangle and its
// top vertex the middle of its top.
class _TrianglePainter extends CustomPainter {
  _TrianglePainter({
    @required this.color,
  });

  final Color color;

  @override
  bool hitTest(Offset point) => true; // Hitting the rectangle is fine enough.

  @override
  bool shouldRepaint(_TrianglePainter oldPainter) {
    return oldPainter.color != color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final double base = size.width;
    final double halfBase = size.width / 2.0;
    final double height = size.height;
    final List<Offset> points = <Offset>[
      Offset(0.0, height),
      Offset(base, height),
      Offset(halfBase, 0.0),
    ];

    canvas.drawPath(
      Path()..addPolygon(points, true),
      Paint()..color = color,
    );
  }
}
