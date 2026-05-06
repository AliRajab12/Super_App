#!/bin/bash

# Generates messages_*.dart files from translated arb files
${FlutterToolPath:-flutter} pub run intl_translation:generate_from_arb --output-dir=lib/core/localization/gen --no-use-deferred-loading lib/core/localization/app_localizations.dart lib/core/localization/arb/intl_*.arb
dart format -l 120 .

echo "Translation classes generated in lib/core/localization/gen/messages_*.dart"