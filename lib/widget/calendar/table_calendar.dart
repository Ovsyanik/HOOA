
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'shared/utils.dart';
import 'table_calendar_base.dart';
import 'widgets/calendar_header.dart';
import 'widgets/cell_content.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

typedef OnDaySelected = void Function(
    DateTime selectedDay, DateTime focusedDay);

typedef OnRangeSelected = void Function(
    DateTime start, DateTime end, DateTime focusedDay);
enum RangeSelectionMode { disabled, toggledOff, toggledOn, enforced }

/// Highly customizable, feature-packed Flutter calendar with gestures, animations and multiple formats.
class TableCalendar<T> extends StatefulWidget {
  final DateTime selectedDay;

  final DateTime focusedDay;

  final DateTime firstDay;

  final DateTime lastDay;

  final List<int> weekendDays;

  final bool pageJumpingEnabled;

  final bool pageAnimationEnabled;

  final bool shouldFillViewport;

  final double daysOfWeekHeight;

  final Duration formatAnimationDuration;

  final Curve formatAnimationCurve;

  final Duration pageAnimationDuration;

  final Curve pageAnimationCurve;

  final HitTestBehavior dayHitTestBehavior;

  final AvailableGestures availableGestures;

  final SimpleSwipeConfig simpleSwipeConfig;

  final bool Function(DateTime day) enabledDayPredicate;

  final bool Function(DateTime day) selectedDayPredicate;

  final bool Function(DateTime day) holidayPredicate;

  final OnDaySelected onDaySelected;

  final void Function(DateTime day) onDisabledDayTapped;

  final void Function(DateTime day) onDisabledDayLongPressed;

  final void Function(DateTime focusedDay) onPageChanged;

  final void Function(PageController pageController) onCalendarCreated;

  TableCalendar({
    Key key,
    @required DateTime focusedDay,
    @required DateTime firstDay,
    @required DateTime lastDay,
    this.selectedDay,
    this.weekendDays = const [DateTime.saturday, DateTime.sunday],
    this.pageJumpingEnabled = false,
    this.pageAnimationEnabled = true,
    this.shouldFillViewport = false,
    this.daysOfWeekHeight = 16.0,
    this.formatAnimationDuration = const Duration(milliseconds: 200),
    this.formatAnimationCurve = Curves.linear,
    this.pageAnimationDuration = const Duration(milliseconds: 300),
    this.pageAnimationCurve = Curves.easeOut,
    this.dayHitTestBehavior = HitTestBehavior.opaque,
    this.availableGestures = AvailableGestures.all,
    this.simpleSwipeConfig = const SimpleSwipeConfig(
      verticalThreshold: 25.0,
      swipeDetectionBehavior: SwipeDetectionBehavior.continuousDistinct,
    ),
    this.enabledDayPredicate,
    this.selectedDayPredicate,
    this.holidayPredicate,
    this.onDaySelected,
    this.onDisabledDayTapped,
    this.onDisabledDayLongPressed,
    this.onPageChanged,
    this.onCalendarCreated,
  }) : assert(weekendDays.isNotEmpty
            ? weekendDays.every(
                (day) => day >= DateTime.monday && day <= DateTime.sunday)
            : true),
        focusedDay = normalizeDate(focusedDay),
        firstDay = normalizeDate(firstDay),
        lastDay = normalizeDate(lastDay),
        super(key: key);

  @override
  _TableCalendarState<T> createState() => _TableCalendarState<T>();
}

class _TableCalendarState<T> extends State<TableCalendar<T>> {
  PageController _pageController;
  ValueNotifier<DateTime> _focusedDay;
  List<BoxDecoration> decorations;


  @override
  void initState() {
    super.initState();
    _focusedDay = ValueNotifier(widget.focusedDay);
  }

  @override
  void didUpdateWidget(TableCalendar<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_focusedDay.value != widget.focusedDay) {
      _focusedDay.value = widget.focusedDay;
    }
  }

  @override
  void dispose() {
    _focusedDay.dispose();
    super.dispose();
  }

  bool get _shouldBlockOutsideDays => true;

  void _onDayTapped(DateTime day) {
    final isOutside = day.month != _focusedDay.value.month;
    if (isOutside && _shouldBlockOutsideDays) {
      return;
    }

    if (_isDayDisabled(day)) {
      return widget.onDisabledDayTapped?.call(day);
    }

    _updateFocusOnTap(day);

    widget.onDaySelected?.call(day, _focusedDay.value);

  }

  void _updateFocusOnTap(DateTime day) {
    if (widget.pageJumpingEnabled) {
      _focusedDay.value = day;
      return;
    }

    if (_isBeforeMonth(day, _focusedDay.value)) {
      _focusedDay.value = _firstDayOfMonth(_focusedDay.value);
    } else if (_isAfterMonth(day, _focusedDay.value)) {
      _focusedDay.value = _lastDayOfMonth(_focusedDay.value);
    } else {
      _focusedDay.value = day;
    }
  }

  void _onFirstButtonTap() {
    decorations = [
      BoxDecoration(
        color: HexColor('#4E7D96'),
        border: Border.all(color: HexColor('#4E7D96'), width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      null,
      null,
      null
    ];
    _pageController.jumpToPage(DateTime.now().month + 2);
  }

  void _onSecondButtonTap() {
    decorations = [
      null,
      BoxDecoration(
        color: HexColor('#4E7D96'),
        border: Border.all(color: HexColor('#4E7D96'), width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      null,
      null
    ];
    _pageController.jumpToPage(DateTime.now().month + 3);
  }

  void _onThirdButtonTap() {
    decorations = [
      null,
      null,
      BoxDecoration(
        color: HexColor('#4E7D96'),
        border: Border.all(color: HexColor('#4E7D96'), width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      null
    ];
    _pageController.jumpToPage(DateTime.now().month + 4);
  }

  void _onFourthButtonTap() {
    decorations = [
      null,
      null,
      null,
      BoxDecoration(
        color: HexColor('#4E7D96'),
        border: Border.all(color: HexColor('#4E7D96'), width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      )
    ];
    _pageController.jumpToPage(DateTime.now().month + 5);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder<DateTime>(
          valueListenable: _focusedDay,
          builder: (context, value, _) {
            return CalendarHeader(
              decorations: this.decorations,
              selectedDate: widget.selectedDay,
              onFirstButtonTap: _onFirstButtonTap,
              onFourthButtonTap: _onFourthButtonTap,
              onSecondButtonTap: _onSecondButtonTap,
              onThirdButtonTap: _onThirdButtonTap,
            );
          },
        ),
        Flexible(
          flex: widget.shouldFillViewport ? 1 : 0,
          child: TableCalendarBase(
            onCalendarCreated: (pageController) {
              _pageController = pageController;
              widget.onCalendarCreated?.call(pageController);
            },
            focusedDay: _focusedDay.value,
            availableGestures: widget.availableGestures,
            firstDay: widget.firstDay,
            lastDay: widget.lastDay,

            rowDecoration: const BoxDecoration(),
            dowHeight: widget.daysOfWeekHeight,
            formatAnimationDuration: widget.formatAnimationDuration,
            formatAnimationCurve: widget.formatAnimationCurve,
            pageAnimationEnabled: widget.pageAnimationEnabled,
            pageAnimationDuration: widget.pageAnimationDuration,
            pageAnimationCurve: widget.pageAnimationCurve,
            simpleSwipeConfig: widget.simpleSwipeConfig,
            onPageChanged: (focusedDay) {
              _focusedDay.value = focusedDay;
              widget.onPageChanged?.call(focusedDay);
            },
            dowBuilder: (BuildContext context, DateTime day) {
              return Center(
                  child: Text(
                    DateFormat.E('ru_RU').format(day)[0].toUpperCase()
                  ),
                );
            },
            dayBuilder: (context, day, focusedMonth) {
              return GestureDetector(
                behavior: widget.dayHitTestBehavior,
                onTap: () => _onDayTapped(day),
                child: _buildCell(day, focusedMonth),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCell(DateTime day, DateTime focusedDay) {
    final isOutside = day.month != focusedDay.month;

    if (isOutside && _shouldBlockOutsideDays) {
      return Container();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final children = <Widget>[];

        final isToday = isSameDay(day, DateTime.now());
        final isDisabled = _isDayDisabled(day);
        final isWeekend = _isWeekend(day, weekendDays: widget.weekendDays);

        Widget content = CellContent(
          day: day,
          focusedDay: focusedDay,
          isTodayHighlighted: true,
          isToday: isToday,
          isSelected: widget.selectedDayPredicate?.call(day) ?? false,
          isOutside: isOutside,
          isDisabled: isDisabled,
          isWeekend: isWeekend,
          isHoliday: widget.holidayPredicate?.call(day) ?? false,
        );

        children.add(content);

        return Stack(
          alignment:  Alignment.bottomCenter,
          children: children,
          clipBehavior: Clip.none
        );
      },
    );
  }

  bool _isDayDisabled(DateTime day) {
    return day.isBefore(widget.firstDay) ||
        day.isAfter(widget.lastDay) ||
        !_isDayAvailable(day);
  }

  bool _isDayAvailable(DateTime day) {
    return widget.enabledDayPredicate == null
        ? true
        : widget.enabledDayPredicate(day);
  }

  DateTime _firstDayOfMonth(DateTime month) {
    return DateTime.utc(month.year, month.month, 1);
  }

  DateTime _lastDayOfMonth(DateTime month) {
    final date = month.month < 12
        ? DateTime.utc(month.year, month.month + 1, 1)
        : DateTime.utc(month.year + 1, 1, 1);
    return date.subtract(const Duration(days: 1));
  }

  bool _isBeforeMonth(DateTime day, DateTime month) {
    if (day.year == month.year) {
      return day.month < month.month;
    } else {
      return day.isBefore(month);
    }
  }

  bool _isAfterMonth(DateTime day, DateTime month) {
    if (day.year == month.year) {
      return day.month > month.month;
    } else {
      return day.isAfter(month);
    }
  }

  bool _isWeekend(
    DateTime day, {
    List<int> weekendDays = const [DateTime.saturday, DateTime.sunday],
  }) {
    return weekendDays.contains(day.weekday);
  }
}