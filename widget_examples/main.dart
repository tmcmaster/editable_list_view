import 'package:flutter/material.dart';
import 'package:flutter_workbench/flutter_workbench.dart';

import 'app_style.dart';
import 'examples.dart';

void main() {
  runApp(
    StyledRiverpodApp(
      themes: AppStyle.themes,
      logging: false,
      overrides: [
        WidgetExamplesTesterProviders.exampleBuildersList.overrideWithValue([
          EditableListViewExamplesBuilder(),
        ]),
      ],
      child: WidgetExamplesTester(),
    ),
  );
}
