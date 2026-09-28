import 'package:beer_logger/bounded_contexts/portion/domain/clicker/clicker.dart';
import 'package:beer_logger/bounded_contexts/portion/presentation/portion_input.dart';
import 'package:beer_logger/core/di/clicker_settings_repository.cg.dart';
import 'package:beer_logger/bounded_contexts/portion/application/current_clicker.cg.dart';
import 'package:beer_logger/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Максимальная ширина формы и кнопки на экране порции.
const _settingsContentMaxWidth = 400.0;

/// Экран порции: четыре числа и сохранение.
///
/// Поля заполняются из [currentClicker] один раз. Дальше правка живёт в
/// контроллерах, пока человек не нажмёт Save. Название clicker не редактируется.
class SettingsPage extends ConsumerStatefulWidget {
  /// Создаёт экран настроек порции.
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  final _volume = TextEditingController();
  final _energy = TextEditingController();
  final _money = TextEditingController();
  final _joy = TextEditingController();

  var _filledFromClicker = false;
  var _saving = false;
  String? _volumeError;
  String? _energyError;
  String? _moneyError;
  String? _joyError;

  @override
  void dispose() {
    _volume.dispose();
    _energy.dispose();
    _money.dispose();
    _joy.dispose();
    super.dispose();
  }

  void _fill(Clicker clicker) {
    if (_filledFromClicker) return;
    _filledFromClicker = true;
    _volume.text = formatPortionInput(
      portionEntered(clicker, PortionField.volume),
    );
    _energy.text = formatPortionInput(
      portionEntered(clicker, PortionField.energy),
    );
    _money.text = formatPortionInput(
      portionEntered(clicker, PortionField.money),
    );
    _joy.text = formatPortionInput(portionEntered(clicker, PortionField.joy));
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    final volumeError = portionInputIsValid(PortionField.volume, _volume.text)
        ? null
        : l10n.settingsVolumeRangeError;
    final energyError = portionInputIsValid(PortionField.energy, _energy.text)
        ? null
        : l10n.settingsEnergyRangeError;
    final moneyError = portionInputIsValid(PortionField.money, _money.text)
        ? null
        : l10n.settingsMoneyRangeError;
    final joyError = portionInputIsValid(PortionField.joy, _joy.text)
        ? null
        : l10n.settingsJoyRangeError;
    setState(() {
      _volumeError = volumeError;
      _energyError = energyError;
      _moneyError = moneyError;
      _joyError = joyError;
    });
    if (volumeError != null ||
        energyError != null ||
        moneyError != null ||
        joyError != null) {
      return;
    }

    final clicker = ref.read(currentClickerProvider).asData?.value;
    if (clicker == null) return;

    final volume = tryParsePortion(_volume.text);
    final energy = tryParsePortion(_energy.text);
    final money = tryParsePortion(_money.text);
    final joy = tryParsePortion(_joy.text);
    if (volume == null || energy == null || money == null || joy == null) {
      return;
    }

    setState(() => _saving = true);
    final result = await ref
        .read(clickerSettingsRepositoryProvider)
        .saveClicker(
          clickerWithPortion(
            clicker,
            volume: volume,
            energy: energy,
            money: money,
            joy: joy,
          ),
        );
    if (!mounted) return;
    setState(() => _saving = false);
    result.fold((_) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.settingsSaveError)));
    }, (_) => context.pop());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final asyncClicker = ref.watch(currentClickerProvider);
    final clicker = asyncClicker.asData?.value;
    if (clicker != null) _fill(clicker);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: clicker == null
          ? const SafeArea(child: Center(child: CircularProgressIndicator()))
          : SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: _settingsContentMaxWidth,
                        ),
                        child: ListView(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                          children: [
                            _field(
                              controller: _volume,
                              label: l10n.settingsVolumeLabel,
                              error: _volumeError,
                              fieldKey: const Key('settings-volume'),
                            ),
                            const SizedBox(height: 12),
                            _field(
                              controller: _energy,
                              label: l10n.settingsEnergyLabel,
                              helper: l10n.settingsEnergyHelper,
                              error: _energyError,
                              fieldKey: const Key('settings-energy'),
                            ),
                            const SizedBox(height: 12),
                            _field(
                              controller: _money,
                              label: l10n.settingsMoneyLabel,
                              error: _moneyError,
                              fieldKey: const Key('settings-money'),
                            ),
                            const SizedBox(height: 12),
                            _field(
                              controller: _joy,
                              label: l10n.settingsJoyLabel,
                              error: _joyError,
                              fieldKey: const Key('settings-joy'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Align(
                      alignment: Alignment.center,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: _settingsContentMaxWidth,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: _saving ? null : _save,
                            child: Text(l10n.settingsSave),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    required String? error,
    required Key fieldKey,
    String? helper,
  }) {
    return TextField(
      key: fieldKey,
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        helperText: helper,
        errorText: error,
      ),
    );
  }
}
