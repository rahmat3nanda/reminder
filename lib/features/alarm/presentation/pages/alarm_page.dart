import 'package:flutter/material.dart'
    show
        BuildContext,
        Divider,
        FloatingActionButton,
        GestureDetector,
        Icon,
        Icons,
        ListView,
        StatelessWidget,
        Widget;
import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocBuilder, BlocProvider, ReadContext;
import 'package:reminder/cores/navigate.dart' show AppNavigate;
import 'package:reminder/cores/themes/bloc/theme_bloc.dart'
    show ThemeBloc, ThemeState;
import 'package:reminder/features/alarm/data/alarm.hive_key.dart'
    show AlarmHiveKey;
import 'package:reminder/features/alarm/data/datasources/alarm_local_datasource.dart'
    show AlarmLocalDatasource;
import 'package:reminder/features/alarm/domain/entities/alarm.dart' show Alarm;
import 'package:reminder/features/alarm/domain/entities/alarm_time.dart'
    show AlarmTime;
import 'package:reminder/features/alarm/presentation/bloc/alarm_bloc.dart'
    show AddAlarm, AlarmBloc, AlarmState, LoadAlarms;
import 'package:reminder/features/alarm/presentation/sheets/alarm_add_sheet.dart'
    show AlarmAddSheet;
import 'package:reminder/features/setting/presentation/pages/setting_page.dart'
    show SettingPage;
import 'package:reminder/shared/widgets.dart'
    show RemUIAppBar, RemUIScaffold, RemUISvg, RemUIText;

class AlarmPage extends StatelessWidget {
  const AlarmPage({super.key});

  @override
  Widget build(_) => BlocProvider<AlarmBloc>(
    create: (_) =>
        AlarmBloc(AlarmLocalDatasource(AlarmHiveKey.box))
          ..add(const LoadAlarms()),
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
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final AlarmBloc bloc = context.read<AlarmBloc>();
            final AlarmTime? time = await AlarmAddSheet.show(context);
            if (time == null) return;
            bloc.add(AddAlarm(Alarm(time: time)));
          },
          backgroundColor: state.color.primary.value,
          child: Icon(Icons.add, color: state.color.primarySoft.value),
        ),
        body: BlocBuilder<AlarmBloc, AlarmState>(
          builder: (_, AlarmState state) => ListView.separated(
            itemCount: state.data.length,
            separatorBuilder: (_, _) => const Divider(),
            itemBuilder: (_, int i) {
              final Alarm item = state.data[i];
              return RemUIText(item.time.hour.toString());
            },
          ),
        ),
      ),
    ),
  );
}
