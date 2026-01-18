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
        State,
        StatefulWidget,
        VoidCallback,
        Widget,
        kToolbarHeight,
        showModalBottomSheet;
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, ReadContext;
import 'package:just_audio/just_audio.dart' show AudioPlayer;
import 'package:reminder/cores/colors/color.dart' show AppColor, AppColorBase;
import 'package:reminder/cores/themes/bloc/theme_bloc.dart' show ThemeBloc;
import 'package:reminder/features/reminder/domain/entities/reminder_time.dart'
    show ReminderTime;
import 'package:reminder/features/reminder/domain/enums/sound.dart'
    show Sound, SoundResolver;
import 'package:reminder/features/reminder/presentation/extensions/sound_string.dart'
    show SoundString;
import 'package:reminder/features/reminder/presentation/sheets/bloc/reminder_form_cubit.dart'
    show ReminderFormCubit, ReminderFormState;
import 'package:reminder/shared/widgets.dart' show RemUIText;

class ReminderSoundSheet extends StatefulWidget {
  const ReminderSoundSheet({required this.cubit, super.key});

  final ReminderFormCubit cubit;

  static Future<ReminderTime?> show(
    BuildContext context, {
    required ReminderFormCubit cubit,
  }) => showModalBottomSheet<ReminderTime?>(
    context: context,
    isScrollControlled: true,
    builder: (_) => ReminderSoundSheet(cubit: cubit),
    backgroundColor: Colors.transparent,
  );

  @override
  State<ReminderSoundSheet> createState() => _ReminderSoundSheetState();
}

class _ReminderSoundSheetState extends State<ReminderSoundSheet> {
  final AudioPlayer _player = AudioPlayer();

  @override
  void dispose() {
    _player.stop();
    _player.dispose();
    super.dispose();
  }

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
                    'Sound',
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
              bloc: widget.cubit,
              builder: (_, ReminderFormState s) => ListView.separated(
                padding: .zero,
                itemCount: Sound.values.length,
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
                itemBuilder: (_, int i) {
                  final Sound sound = Sound.values[i];
                  return InkWell(
                    onTap: () async {
                      widget.cubit.setSound(sound);
                      if (sound != Sound.none) {
                        await _player.stop();
                        await _player.setAsset(sound.preview);
                        await _player.play();
                      }
                    },
                    child: Padding(
                      padding: const .symmetric(vertical: 16, horizontal: 24),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: RemUIText(sound.display, fontSize: 16),
                          ),
                          if (s.sound == sound)
                            Icon(Icons.check, color: color.primary.value),
                        ],
                      ),
                    ),
                  );
                },
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
