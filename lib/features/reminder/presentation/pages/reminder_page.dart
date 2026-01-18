import 'package:flutter/material.dart'
    show
        BuildContext,
        Center,
        Column,
        Divider,
        Expanded,
        FloatingActionButton,
        GestureDetector,
        Icon,
        Icons,
        ListView,
        Row,
        StatelessWidget,
        Widget;
import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocBuilder, BlocProvider, ReadContext;
import 'package:reminder/cores/navigate.dart' show AppNavigate;
import 'package:reminder/cores/themes/bloc/theme_bloc.dart'
    show ThemeBloc, ThemeState;
import 'package:reminder/features/reminder/data/datasources/reminder_local_datasource.dart'
    show ReminderLocalDatasource;
import 'package:reminder/features/reminder/data/reminder.hive_key.dart'
    show ReminderHiveKey;
import 'package:reminder/features/reminder/domain/entities/reminder.dart'
    show Reminder;
import 'package:reminder/features/reminder/domain/entities/reminder_time.dart'
    show ReminderTime;
import 'package:reminder/features/reminder/presentation/bloc/reminder_bloc.dart'
    show AddReminder, LoadReminders, ReminderBloc, ReminderState;
import 'package:reminder/features/reminder/presentation/extensions/reminder_time_string.dart'
    show ReminderTimeString;
import 'package:reminder/features/reminder/presentation/sheets/reminder_add_sheet.dart'
    show ReminderAddSheet;
import 'package:reminder/features/setting/presentation/pages/setting_page.dart'
    show SettingPage;
import 'package:reminder/shared/widgets.dart'
    show RemUIAppBar, RemUIScaffold, RemUISvg, RemUIText;

class ReminderPage extends StatelessWidget {
  const ReminderPage({super.key});

  @override
  Widget build(_) => BlocProvider<ReminderBloc>(
    create: (_) =>
        ReminderBloc(ReminderLocalDatasource(ReminderHiveKey.box))
          ..add(const LoadReminders()),
    child: BlocBuilder<ThemeBloc, ThemeState>(
      builder: (BuildContext context, ThemeState state) => RemUIScaffold(
        appBar: RemUIAppBar(
          trailing: <Widget>[
            GestureDetector(
              onTap: () => AppNavigate.to(context, const SettingPage()),
              child: RemUISvg(
                asset: 'assets/svg/setting.svg',
                color: state.color.text,
              ),
            ),
          ],
          child: const RemUIText('Reminders', fontWeight: .w600, fontSize: 18),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final ReminderBloc bloc = context.read<ReminderBloc>();
            final ReminderTime? time = await ReminderAddSheet.show(context);
            if (time == null) return;
            bloc.add(AddReminder(Reminder.create(time: time)));
          },
          backgroundColor: state.color.primary.value,
          child: Icon(Icons.add, color: state.color.primarySoft.value),
        ),
        body: BlocBuilder<ReminderBloc, ReminderState>(
          builder: (_, ReminderState state) {
            if (state.data.isEmpty) {
              return const Center(child: RemUIText('No Reminder'));
            }

            return ListView.separated(
              padding: const .symmetric(vertical: 12, horizontal: 16),
              itemCount: state.data.length,
              separatorBuilder: (_, _) => const Divider(),
              itemBuilder: (_, int i) {
                final Reminder item = state.data[i];
                return Row(
                  spacing: 12,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisSize: .min,
                        crossAxisAlignment: .start,
                        spacing: 4,
                        children: <Widget>[
                          RemUIText(item.time.display(context)),
                          RemUIText(item.label ?? 'Reminder'),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    ),
  );
}
