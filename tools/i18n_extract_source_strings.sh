#!/bin/bash

# Exports strings declared in app_localizations.dart to intl_messages.arb
${FlutterToolPath:-flutter} pub run intl_translation:extract_to_arb --suppress-last-modified --output-dir=lib/core/localization/arb lib/core/localization/app_localizations.dart
dart format -l 120 .

echo "Source strings extracted to lib/core/localization/arb/intl_messages.arb"