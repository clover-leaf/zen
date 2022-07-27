import 'package:flutter/material.dart';
import 'package:flutter_firestore/common/constants/constants.dart';
import 'package:flutter_firestore/common/widgets/widgets.dart';
import 'package:iot_api/iot_api.dart';
import 'package:url_launcher/url_launcher_string.dart';

class JsonExtractionSheet extends StatefulWidget {
  const JsonExtractionSheet({
    super.key,
    required this.initJsonVariable,
    required this.onSaved,
    required this.onDeleted,
  });

  final JsonVariable? initJsonVariable;
  final Function(JsonVariable) onSaved;
  final Function(JsonVariable) onDeleted;

  @override
  State<JsonExtractionSheet> createState() => _JsonExtractionSheetState();
}

class _JsonExtractionSheetState extends State<JsonExtractionSheet> {
  late String title;
  late String jsonExtraction;

  @override
  void initState() {
    super.initState();
    title = widget.initJsonVariable?.title ?? '';
    jsonExtraction = widget.initJsonVariable?.jsonExtraction ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        Space.contentPaddingHorizontal.value,
        32,
        Space.contentPaddingHorizontal.value,
        32 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyTextField(
            initText: title,
            labelText: 'Name',
            prefixIcon: MyIcon.tag.getPath(),
            horizontalPadding: 0,
            onChanged: (newTitle) {
              setState(() {
                title = newTitle;
              });
            },
          ),
          SizedBox(height: Space.contentItemGap.value),
          MyTextField(
            initText: title,
            labelText: 'JSON path',
            prefixIcon: MyIcon.code.getPath(),
            horizontalPadding: 0,
            onChanged: (newJsonExtraction) {
              setState(() {
                jsonExtraction = newJsonExtraction;
              });
            },
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodySmall,
              children: [
                const TextSpan(
                  text: 'Extracts payload from JSON message. Visit',
                ),
                WidgetSpan(
                  baseline: TextBaseline.alphabetic,
                  alignment: PlaceholderAlignment.baseline,
                  child: InkWell(
                    onTap: () => _launchUrl('https://github.com/f3ath/jessie'),
                    child: Text(
                      ' this link ',
                      style: Theme.of(context).textTheme.bodySmall!.merge(
                            const TextStyle(
                              color: Color(0xff890e4f),
                            ),
                          ),
                    ),
                  ),
                ),
                const TextSpan(
                  text: 'for in-depth instructions.',
                ),
              ],
            ),
          ),
          SizedBox(height: Space.contentItemGap.value),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: MyOutlineButton(
                  content: 'Delete',
                  innerPadding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 8,
                  ),
                  onPressed: () {
                    final jsonVariable = JsonVariable(
                      id: widget.initJsonVariable?.id,
                      deviceID: widget.initJsonVariable?.deviceID ?? '',
                      title: title,
                      jsonExtraction: jsonExtraction,
                    );
                    widget.onDeleted(jsonVariable);
                    Navigator.of(context).pop();
                  },
                ),
              ),
               MyOutlineButton(
                content: 'Save',
                innerPadding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ),
                onPressed: () {
                  final jsonVariable = JsonVariable(
                    id: widget.initJsonVariable?.id,
                    deviceID: widget.initJsonVariable?.deviceID ?? '',
                    title: title,
                    jsonExtraction: jsonExtraction,
                  );
                  widget.onSaved(jsonVariable);
                  Navigator.of(context).pop();
                },
              )
            ],
          )
        ],
      ),
    );
  }

  /// lauch given url
  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw Exception('Could not launch $url');
    }
  }
}
