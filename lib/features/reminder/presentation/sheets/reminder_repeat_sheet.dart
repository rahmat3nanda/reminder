import 'package:flutter/material.dart'
    show
        BoxConstraints,
        BoxDecoration,
        BuildContext,
        Center,
        ClampingScrollPhysics,
        Colors,
        Container,
        Divider,
        Expanded,
        GestureDetector,
        Icon,
        IconData,
        Icons,
        InkWell,
        ListView,
        Material,
        MediaQuery,
        Navigator,
        NeverScrollableScrollPhysics,
        Padding,
        Positioned,
        Row,
        SizedBox,
        Stack,
        StatelessWidget,
        VoidCallback,
        Widget,
        kToolbarHeight,
        showModalBottomSheet;
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, ReadContext;
import 'package:reminder/cores/colors/color.dart' show AppColor, AppColorBase;
import 'package:reminder/cores/themes/bloc/theme_bloc.dart' show ThemeBloc;
import 'package:reminder/features/reminder/domain/entities/reminder_time.dart'
    show ReminderTime;
import 'package:reminder/features/reminder/domain/enums/day.dart' show Day;
import 'package:reminder/features/reminder/presentation/extensions/day_string.dart'
    show DayString;
import 'package:reminder/features/reminder/presentation/sheets/bloc/reminder_form_cubit.dart'
    show ReminderFormCubit, ReminderFormState;
import 'package:reminder/shared/widgets.dart' show RemUIText;

class ReminderRepeatSheet extends StatelessWidget {
  const ReminderRepeatSheet({required this.cubit, super.key});

  final ReminderFormCubit cubit;

  static Future<ReminderTime?> show(
    BuildContext context, {
    required ReminderFormCubit cubit,
  }) => showModalBottomSheet<ReminderTime?>(
    context: context,
    isScrollControlled: true,
    builder: (_) => ReminderRepeatSheet(cubit: cubit),
    backgroundColor: Colors.transparent,
  );

  @override
  Widget build(BuildContext context) {
    final AppColor color = context.read<ThemeBloc>().state.color;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height - kToolbarHeight,
      ),
      decoration: BoxDecoration(
        color: color.card.value,
        borderRadius: .circular(24),
      ),
      child: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: const .symmetric(vertical: 24, horizontal: 16),
        children: <Widget>[
          Stack(
            children: <Widget>[
              _actionButton(
                icon: Icons.close,
                onTap: () => Navigator.pop(context),
                iconColor: color.text,
              ),
              const Positioned.fill(
                child: Center(
                  child: RemUIText(
                    'Repeat',
                    textAlign: .center,
                    fontWeight: .w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Material(
            color: color.greyS3A5.value,
            borderRadius: .circular(12),
            clipBehavior: .antiAlias,
            child: BlocBuilder<ReminderFormCubit, ReminderFormState>(
              bloc: cubit,
              builder: (_, ReminderFormState s) => ListView.separated(
                padding: .zero,
                itemCount: Day.values.length,
                primary: false,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (_, _) => Padding(
                  padding: const .symmetric(horizontal: 16),
                  child: Divider(
                    color: color.grey.value.withValues(alpha: .2),
                    height: 1,
                  ),
                ),
                itemBuilder: (_, int i) => InkWell(
                  onTap: () => cubit.repeatDay(Day.values[i]),
                  child: Padding(
                    padding: const .symmetric(vertical: 16, horizontal: 24),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RemUIText(Day.values[i].display, fontSize: 16),
                        ),
                        if (s.repeatDays.contains(Day.values[i]))
                          Icon(Icons.check, color: color.primary.value),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 64),
        ],
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
}
