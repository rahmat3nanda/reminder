import 'package:flutter/cupertino.dart' show Alignment, CupertinoPicker;
import 'package:flutter/material.dart'
    show
        Align,
        BoxConstraints,
        BoxDecoration,
        BuildContext,
        Center,
        ClampingScrollPhysics,
        Colors,
        Column,
        Container,
        Divider,
        Expanded,
        FixedExtentScrollController,
        Flexible,
        GestureDetector,
        Icon,
        IconData,
        Icons,
        IgnorePointer,
        InkWell,
        ListView,
        MediaQuery,
        Navigator,
        Row,
        SizedBox,
        Stack,
        StatelessWidget,
        VoidCallback,
        Widget,
        kToolbarHeight,
        showModalBottomSheet;
import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocBuilder, BlocProvider, ReadContext;
import 'package:reminder/cores/colors/color.dart' show AppColor, AppColorBase;
import 'package:reminder/cores/themes/bloc/theme_bloc.dart' show ThemeBloc;
import 'package:reminder/features/reminder/domain/entities/reminder_time.dart'
    show ReminderTime;
import 'package:reminder/features/reminder/presentation/extensions/day_string.dart'
    show DaysString;
import 'package:reminder/features/reminder/presentation/sheets/bloc/reminder_add_cubit.dart'
    show ReminderAddCubit, ReminderAddState;
import 'package:reminder/shared/widgets.dart' show RemUIText;

class ReminderAddSheet extends StatelessWidget {
  const ReminderAddSheet({super.key});

  static Future<ReminderTime?> show(BuildContext context) =>
      showModalBottomSheet<ReminderTime?>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) => const ReminderAddSheet(),
        backgroundColor: Colors.transparent,
      );

  @override
  Widget build(BuildContext context) {
    final bool use24Format = MediaQuery.of(context).alwaysUse24HourFormat;
    final AppColor color = context.read<ThemeBloc>().state.color;

    return BlocProvider<ReminderAddCubit>(
      create: (_) => ReminderAddCubit(use24Format: use24Format),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height - kToolbarHeight,
        decoration: BoxDecoration(
          color: color.card.value,
          borderRadius: .circular(24),
        ),
        child: ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          padding: const .symmetric(vertical: 24, horizontal: 16),
          children: <Widget>[
            Row(
              spacing: 12,
              children: <Widget>[
                _actionButton(
                  icon: Icons.close,
                  onTap: () => Navigator.pop(context),
                  iconColor: color.text,
                ),
                const Expanded(
                  child: RemUIText(
                    'Add Reminder',
                    textAlign: .center,
                    fontWeight: .w600,
                    fontSize: 16,
                  ),
                ),
                BlocBuilder<ReminderAddCubit, ReminderAddState>(
                  builder: (_, ReminderAddState state) => _actionButton(
                    icon: Icons.check,
                    onTap: () => Navigator.pop(context, state.reminderTime),
                    backgroundColor: color.primary,
                    iconColor: color.primarySoft,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            BlocBuilder<ReminderAddCubit, ReminderAddState>(
              builder: (BuildContext context, ReminderAddState state) =>
                  SizedBox(
                    height: 156,
                    child: Stack(
                      fit: .expand,
                      children: <Widget>[
                        Row(
                          spacing: 8,
                          children: <Widget>[
                            _picker(
                              color: color,
                              itemCount: use24Format ? 24 : 12,
                              initialIndex: state.hourPickerIndex,
                              alignment: .centerRight,
                              offAxisFraction: -.5,
                              labelBuilder: (int i) => (use24Format ? i : i + 1)
                                  .toString()
                                  .padLeft(2, '0'),
                              onChanged: context
                                  .read<ReminderAddCubit>()
                                  .setHourFromPicker,
                            ),
                            _picker(
                              color: color,
                              alignment: use24Format ? .centerLeft : .center,
                              offAxisFraction: use24Format ? .5 : 0,
                              itemCount: 60,
                              initialIndex: state.minutePickerIndex,
                              labelBuilder: (int i) =>
                                  i.toString().padLeft(2, '0'),
                              onChanged: context
                                  .read<ReminderAddCubit>()
                                  .setMinute,
                            ),
                            if (!use24Format)
                              _picker(
                                color: color,
                                alignment: .centerLeft,
                                offAxisFraction: .5,
                                itemCount: 2,
                                initialIndex: state.amPmIndex,
                                labelBuilder: (int i) =>
                                    <String>['AM', 'PM'][i],
                                looping: false,
                                onChanged: context
                                    .read<ReminderAddCubit>()
                                    .setAmPm,
                              ),
                          ],
                        ),
                        Align(
                          child: IgnorePointer(
                            child: Container(
                              width: .infinity,
                              height: 28,
                              decoration: BoxDecoration(
                                color: color.greyS3A5.value,
                                borderRadius: .circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const .all(12),
              decoration: BoxDecoration(
                color: color.greyS3A5.value,
                borderRadius: .circular(12),
              ),
              child: BlocBuilder<ReminderAddCubit, ReminderAddState>(
                builder: (_, s) => Column(
                  mainAxisSize: .min,
                  children: <Widget>[
                    _field(
                      title: 'Repeat',
                      value: RemUIText(s.repeatDays.display, textAlign: .right),
                      onTap: () {},
                    ),
                    Divider(color: color.grey.value.withValues(alpha: .2)),
                    _field(title: 'Label'),
                    Divider(color: color.grey.value.withValues(alpha: .2)),
                    // _field(title: 'Sound'),
                    // Divider(color: color.grey.value.withValues(alpha: .2)),
                    _field(title: 'Snooze'),
                    Divider(color: color.grey.value.withValues(alpha: .2)),
                    _field(title: 'Snooze Duration'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    VoidCallback? onTap,
    AppColorBase? backgroundColor,
    AppColorBase? iconColor,
  }) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(shape: .circle, color: backgroundColor?.value),
      child: Center(child: Icon(icon, color: iconColor?.value)),
    ),
  );

  Widget _field({required String title, Widget? value, VoidCallback? onTap}) =>
      InkWell(
        onTap: onTap,
        child: Row(
          spacing: 12,
          children: <Widget>[
            RemUIText(title, fontSize: 16),
            Expanded(child: value ?? const SizedBox.shrink()),
          ],
        ),
      );

  Widget _picker({
    required AppColor color,
    required int itemCount,
    required String Function(int index) labelBuilder,
    required void Function(int index) onChanged,
    Alignment? alignment,
    int initialIndex = 0,
    double offAxisFraction = 0,
    bool looping = true,
  }) => Flexible(
    child: Container(
      constraints: const BoxConstraints(minWidth: 24),
      child: CupertinoPicker(
        scrollController: FixedExtentScrollController(
          initialItem: initialIndex,
        ),
        itemExtent: 22,
        magnification: 1.05,
        squeeze: .8,
        useMagnifier: true,
        looping: looping,
        offAxisFraction: offAxisFraction,
        onSelectedItemChanged: onChanged,
        selectionOverlay: const SizedBox.shrink(),
        children: List<Widget>.generate(
          itemCount,
          (int i) => Align(
            alignment: alignment ?? Alignment.center,
            child: RemUIText(
              labelBuilder(i),
              color: color.text,
              fontSize: 18,
              fontWeight: .w600,
              textAlign: .right,
            ),
          ),
        ),
      ),
    ),
  );
}
