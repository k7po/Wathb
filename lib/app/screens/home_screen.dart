import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../theme/design_tokens.dart';
import '../widgets/state_panel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<_LocalMatch> _matches = [];

  Future<void> _createMatch() async {
    final match = await showModalBottomSheet<_LocalMatch>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => const _CreateMatchSheet(),
    );
    if (!mounted || match == null) return;

    setState(() {
      _matches.add(match);
      _matches.sort((a, b) => a.startsAt.compareTo(b.startsAt));
    });
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(WathbSpacing.x4),
        children: [
          Text(strings.homeTitle, style: textTheme.headlineSmall),
          const SizedBox(height: WathbSpacing.x2),
          Text(
            strings.upcomingMatchesDescription,
            style: textTheme.bodyLarge?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: WathbSpacing.x4),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(WathbSpacing.x3),
              child: Row(
                children: [
                  Icon(Icons.info_outline_rounded, color: colors.primary),
                  const SizedBox(width: WathbSpacing.x2),
                  Expanded(
                    child: Text(
                      strings.localMatchesNotice,
                      style: textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: WathbSpacing.x4),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              key: const ValueKey('create-match-button'),
              onPressed: _createMatch,
              icon: const Icon(Icons.add_rounded),
              label: Text(strings.createMatch),
            ),
          ),
          const SizedBox(height: WathbSpacing.x6),
          Text(strings.upcomingMatches, style: textTheme.titleLarge),
          const SizedBox(height: WathbSpacing.x3),
          if (_matches.isEmpty)
            StatePanel(
              status: ContentStatus.empty,
              title: strings.noUpcomingMatchesTitle,
              message: strings.noUpcomingMatchesMessage,
              icon: Icons.event_available_rounded,
            )
          else
            ..._matches.map((match) => _MatchCard(match: match)),
        ],
      ),
    );
  }
}

class _MatchCard extends StatelessWidget {
  const _MatchCard({required this.match});

  final _LocalMatch match;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final localizations = MaterialLocalizations.of(context);
    final time = TimeOfDay.fromDateTime(match.startsAt).format(context);

    return Card(
      key: ValueKey('match-card-${match.startsAt.millisecondsSinceEpoch}'),
      margin: const EdgeInsets.only(bottom: WathbSpacing.x3),
      child: ListTile(
        contentPadding: const EdgeInsets.all(WathbSpacing.x3),
        leading: CircleAvatar(
          backgroundColor: colors.surfaceContainerHighest,
          foregroundColor: colors.primary,
          child: const Icon(Icons.sports_soccer_rounded),
        ),
        title: Text(match.title),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: WathbSpacing.x1),
          child: Text(
            '${match.location}\n${localizations.formatMediumDate(match.startsAt)} · $time',
          ),
        ),
        isThreeLine: true,
      ),
    );
  }
}

class _CreateMatchSheet extends StatefulWidget {
  const _CreateMatchSheet();

  @override
  State<_CreateMatchSheet> createState() => _CreateMatchSheetState();
}

class _CreateMatchSheetState extends State<_CreateMatchSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  late DateTime _startsAt;
  String? _dateTimeError;

  @override
  void initState() {
    super.initState();
    final tomorrow = DateUtils.dateOnly(
      DateTime.now().add(const Duration(days: 1)),
    );
    _startsAt = DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 19);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final strings = AppLocalizations.of(context);
    final today = DateUtils.dateOnly(DateTime.now());
    final initialDate = _startsAt.isBefore(today)
        ? today
        : DateUtils.dateOnly(_startsAt);
    final date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: today,
      lastDate: today.add(const Duration(days: 730)),
      helpText: strings.matchDate,
    );
    if (date == null || !mounted) return;
    setState(() {
      _dateTimeError = null;
      _startsAt = DateTime(
        date.year,
        date.month,
        date.day,
        _startsAt.hour,
        _startsAt.minute,
      );
    });
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_startsAt),
    );
    if (time == null || !mounted) return;
    setState(() {
      _dateTimeError = null;
      _startsAt = DateTime(
        _startsAt.year,
        _startsAt.month,
        _startsAt.day,
        time.hour,
        time.minute,
      );
    });
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    if (!_startsAt.isAfter(DateTime.now())) {
      setState(() {
        _dateTimeError = AppLocalizations.of(context).matchMustBeFuture;
      });
      return;
    }
    Navigator.of(context).pop(
      _LocalMatch(
        title: _titleController.text.trim(),
        location: _locationController.text.trim(),
        startsAt: _startsAt,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final localizations = MaterialLocalizations.of(context);
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          WathbSpacing.x6,
          WathbSpacing.x6,
          WathbSpacing.x6,
          WathbSpacing.x4 + bottomInset,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  strings.createMatch,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: WathbSpacing.x4),
                TextFormField(
                  key: const ValueKey('match-title-field'),
                  controller: _titleController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: strings.matchTitle),
                  validator: (value) => value == null || value.trim().isEmpty
                      ? strings.matchTitleRequired
                      : null,
                ),
                const SizedBox(height: WathbSpacing.x3),
                TextFormField(
                  key: const ValueKey('match-location-field'),
                  controller: _locationController,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(labelText: strings.matchLocation),
                  validator: (value) => value == null || value.trim().isEmpty
                      ? strings.matchLocationRequired
                      : null,
                ),
                const SizedBox(height: WathbSpacing.x3),
                OutlinedButton.icon(
                  key: const ValueKey('match-date-button'),
                  onPressed: _pickDate,
                  icon: const Icon(Icons.calendar_today_rounded),
                  label: Text(
                    '${strings.matchDate}: ${localizations.formatMediumDate(_startsAt)}',
                  ),
                ),
                const SizedBox(height: WathbSpacing.x2),
                OutlinedButton.icon(
                  key: const ValueKey('match-time-button'),
                  onPressed: _pickTime,
                  icon: const Icon(Icons.schedule_rounded),
                  label: Text(
                    '${strings.matchTime}: ${TimeOfDay.fromDateTime(_startsAt).format(context)}',
                  ),
                ),
                if (_dateTimeError != null) ...[
                  const SizedBox(height: WathbSpacing.x2),
                  Text(
                    _dateTimeError!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
                const SizedBox(height: WathbSpacing.x4),
                FilledButton(
                  key: const ValueKey('save-match-button'),
                  onPressed: _save,
                  child: Text(strings.saveMatch),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LocalMatch {
  const _LocalMatch({
    required this.title,
    required this.location,
    required this.startsAt,
  });

  final String title;
  final String location;
  final DateTime startsAt;
}
