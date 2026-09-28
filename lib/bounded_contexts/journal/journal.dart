/// Bounded context «журнал».
///
/// Отвечает на вопрос: что уже случилось.
library;

export 'application/axis_record_inputs.dart';
export 'application/clicks_for_today.cg.dart';
export 'application/record_click.cg.dart';
export 'application/today_balance.cg.dart';
export 'application/undo_last_click.cg.dart';
export 'application/week_axis_charts_for_last_7_days.cg.dart';
export 'domain/click/aggregate_for_period.dart';
export 'domain/click/axis_contribution.dart';
export 'domain/click/axis_record_input.dart';
export 'domain/click/click.dart';
export 'domain/click/click_id.dart';
export 'domain/click/click_repository.dart';
export 'domain/click/period_balances.dart';
export 'domain/click/signed_base_delta.dart';
export 'presentation/home/home_page.dart';
export 'presentation/home/home_ui_model.dart';
export 'presentation/today_balance_card.dart';
export 'presentation/today_balance_format.dart';
export 'presentation/today_clicks_format.dart';
export 'presentation/today_clicks_section.dart';
export 'presentation/week_charts_carousel.dart';
