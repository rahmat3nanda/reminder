import 'package:flutter/cupertino.dart' show Alignment, CupertinoPicker;
import 'package:flutter/material.dart'
    show
        Align,
        AnimatedSize,
        BoxConstraints,
        BoxDecoration,
        BuildContext,
        Center,
        ClampingScrollPhysics,
        Colors,
        Column,
        Container,
        Curves,
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
        InputDecoration,
        ListView,
        Material,
        MediaQuery,
        Navigator,
        Padding,
        Row,
        SizedBox,
        Stack,
        StatelessWidget,
        Switch,
        TextFormField,
        TextStyle,
        VoidCallback,
        Widget,
        kToolbarHeight,
        showModalBottomSheet;
import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocBuilder, BlocProvider, ReadContext;
import 'package:reminder/cores/colors/color.dart' show AppColor, AppColorBase;
import 'package:reminder/cores/themes/bloc/theme_bloc.dart' show ThemeBloc;
import 'package:reminder/features/reminder/domain/entities/reminder.dart'
    show Reminder;
import 'package:reminder/features/reminder/presentation/extensions/day_string.dart'
    show DaysString;
import 'package:reminder/features/reminder/presentation/extensions/sound_string.dart'
    show SoundString;
import 'package:reminder/features/reminder/presentation/sheets/bloc/reminder_form_cubit.dart'
    show ReminderFormCubit, ReminderFormState;
import 'package:reminder/features/reminder/presentation/sheets/reminder_repeat_sheet.dart'
    show ReminderRepeatSheet;
import 'package:reminder/features/reminder/presentation/sheets/reminder_sound_sheet.dart'
    show ReminderSoundSheet;
import 'package:reminder/shared/widgets.dart' show RemUIText;

class ReminderFormSheet extends StatelessWidget {
  const ReminderFormSheet({this.item, super.key});

  final Reminder? item;

  static Future<Reminder?> show(BuildContext context, {Reminder? item}) =>
      showModalBottomSheet<Reminder?>(
        context: context,
        isScrollControlled: true,
        builder: (_) => ReminderFormSheet(item: item),
        backgroundColor: Colors.transparent,
      );

  @override
  Widget build(BuildContext context) {
    final bool use24Format = MediaQuery.of(context).alwaysUse24HourFormat;
    final AppColor color = context.read<ThemeBloc>().state.color;

    return BlocProvider<ReminderFormCubit>(
      create: (_) => ReminderFormCubit(use24Format: use24Format, initial: item),
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
                Expanded(
                  child: BlocBuilder<ReminderFormCubit, ReminderFormState>(
                    builder: (_, ReminderFormState state) => RemUIText(
                      '${state.isEdit ? 'Edit' : 'Add'} Reminder',
                      textAlign: .center,
                      fontWeight: .w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                BlocBuilder<ReminderFormCubit, ReminderFormState>(
                  builder: (_, ReminderFormState state) => _actionButton(
                    icon: Icons.check,
                    onTap: () => Navigator.pop(context, state.data),
                    backgroundColor: color.primary,
                    iconColor: color.primarySoft,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            BlocBuilder<ReminderFormCubit, ReminderFormState>(
              builder: (BuildContext context, ReminderFormState state) =>
                  SizedBox(
                    height: 156,
                    child: Stack(
                      fit: .expand,
                      children: <Widget>[
                        Row(
                          spacing: 8,
                          children: <Widget>[
                            Flexible(
                              child: _picker(
                                color: color,
                                itemCount: use24Format ? 24 : 12,
                                initialIndex: state.hourPickerIndex,
                                alignment: .centerRight,
                                offAxisFraction: -.5,
                                labelBuilder: (int i) =>
                                    (use24Format ? i : i + 1)
                                        .toString()
                                        .padLeft(2, '0'),
                                onChanged: context
                                    .read<ReminderFormCubit>()
                                    .setHourFromPicker,
                              ),
                            ),
                            Flexible(
                              child: _picker(
                                color: color,
                                alignment: use24Format ? .centerLeft : .center,
                                offAxisFraction: use24Format ? .5 : 0,
                                itemCount: 60,
                                initialIndex: state.minutePickerIndex,
                                labelBuilder: (int i) =>
                                    i.toString().padLeft(2, '0'),
                                onChanged: context
                                    .read<ReminderFormCubit>()
                                    .setMinute,
                              ),
                            ),
                            if (!use24Format)
                              Flexible(
                                child: _picker(
                                  color: color,
                                  alignment: .centerLeft,
                                  offAxisFraction: .5,
                                  itemCount: 2,
                                  initialIndex: state.amPmIndex,
                                  labelBuilder: (int i) =>
                                      <String>['AM', 'PM'][i],
                                  looping: false,
                                  onChanged: context
                                      .read<ReminderFormCubit>()
                                      .setAmPm,
                                ),
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
            Material(
              clipBehavior: .antiAlias,
              color: color.greyS3A5.value,
              borderRadius: .circular(12),
              child: BlocBuilder<ReminderFormCubit, ReminderFormState>(
                builder: (BuildContext context, ReminderFormState s) =>
                    AnimatedSize(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOutCubic,
                      child: Column(
                        mainAxisSize: .min,
                        children: <Widget>[
                          _field(
                            title: 'Repeat',
                            value: RemUIText(
                              s.repeatDays.display,
                              textAlign: .right,
                            ),
                            onTap: () => ReminderRepeatSheet.show(
                              context,
                              cubit: context.read<ReminderFormCubit>(),
                            ),
                          ),
                          _divider(color),
                          _field(
                            title: 'Label',
                            value: TextFormField(
                              textInputAction: .done,
                              initialValue: s.label,
                              onChanged: context
                                  .read<ReminderFormCubit>()
                                  .setLabel,
                              decoration: const InputDecoration(
                                hintText: 'Reminder',
                                border: .none,
                              ),
                              textAlign: .right,
                              style: TextStyle(color: color.text.value),
                            ),
                          ),
                          _divider(color),
                          _field(
                            title: 'Sound',
                            value: RemUIText(
                              s.sound.display,
                              textAlign: .right,
                            ),
                            onTap: () => ReminderSoundSheet.show(
                              context,
                              cubit: context.read<ReminderFormCubit>(),
                            ),
                          ),
                          _divider(color),
                          _field(
                            title: 'Snooze',
                            value: Align(
                              alignment: .centerRight,
                              child: Switch(
                                value: s.snooze,
                                onChanged: (_) => context
                                    .read<ReminderFormCubit>()
                                    .toggleSnooze(),
                              ),
                            ),
                          ),
                          if (s.snooze) ...<Widget>[
                            _divider(color),
                            _field(
                              title: 'Snooze Duration',
                              value: RemUIText(
                                '${s.snoozeMinutes ?? 1} min',
                                color: color.primary,
                                textAlign: .right,
                              ),
                              onTap: () => context
                                  .read<ReminderFormCubit>()
                                  .toggleSnoozeExpand(),
                            ),
                          ],
                          if (s.snoozeExpand)
                            SizedBox(
                              height: 156,
                              child: _picker(
                                color: color,
                                itemCount: 15,
                                initialIndex: ((s.snoozeMinutes ?? 0) - 1)
                                    .clamp(0, 14),
                                looping: false,
                                labelBuilder: (int i) => '${i + 1} min',
                                onChanged: (int i) => context
                                    .read<ReminderFormCubit>()
                                    .setSnoozeMinutes(i + 1),
                              ),
                            ),
                        ],
                      ),
                    ),
              ),
            ),
            BlocBuilder<ReminderFormCubit, ReminderFormState>(
              builder: (_, ReminderFormState s) {
                if (!s.isEdit) {
                  return const SizedBox.shrink();
                }

                return Padding(
                  padding: const .only(top: 24),
                  child: Material(
                    clipBehavior: .antiAlias,
                    color: color.greyS3A5.value,
                    borderRadius: .circular(12),
                    child: InkWell(
                      onTap: () =>
                          Navigator.pop(context, s.data.copyWith(delete: true)),
                      child: Container(
                        padding: const .symmetric(vertical: 16, horizontal: 24),
                        width: .infinity,
                        child: Center(
                          child: RemUIText(
                            'Delete Reminder',
                            color: color.error,
                            fontWeight: .w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider(AppColor color) => Padding(
    padding: const .symmetric(horizontal: 16),
    child: Divider(color: color.grey.value.withValues(alpha: .2), height: 1),
  );

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
        child: Padding(
          padding: const .symmetric(vertical: 16, horizontal: 24),
          child: Row(
            spacing: 12,
            children: <Widget>[
              RemUIText(title, fontSize: 16),
              Expanded(child: value ?? const SizedBox.shrink()),
            ],
          ),
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
  }) => Container(
    constraints: const BoxConstraints(minWidth: 24),
    child: CupertinoPicker(
      scrollController: FixedExtentScrollController(initialItem: initialIndex),
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
  );
}
