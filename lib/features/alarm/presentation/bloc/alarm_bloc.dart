import 'package:equatable/equatable.dart' show Equatable;
import 'package:flutter_bloc/flutter_bloc.dart' show Bloc, Emitter;
import 'package:reminder/features/alarm/data/datasources/alarm_datasource_interface.dart';
import 'package:reminder/features/alarm/domain/entities/alarm.dart' show Alarm;

part 'alarm_event.dart';
part 'alarm_state.dart';

class AlarmBloc extends Bloc<AlarmEvent, AlarmState> {
  AlarmBloc(this.source) : super(const AlarmState(data: <Alarm>[])) {
    on<LoadAlarms>(_onLoad);
    on<AddAlarm>(_onAdd);
  }

  final AlarmDatasource source;

  Future<void> _onLoad(LoadAlarms event, Emitter<AlarmState> emit) async {
    final List<Alarm>? alarms = await source.get();
    emit(AlarmState(data: alarms ?? <Alarm>[]));
  }

  Future<void> _onAdd(AddAlarm event, Emitter<AlarmState> emit) async {
    await source.save(event.item);

    emit(AlarmState(data: <Alarm>[...state.data, event.item]));
  }
}
