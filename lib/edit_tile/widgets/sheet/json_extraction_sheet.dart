import 'package:flutter/material.dart';
import 'package:flutter_firestore/common/constants/constants.dart';
import 'package:flutter_firestore/edit_tile/widgets/widgets.dart';
import 'package:url_launcher/url_launcher_string.dart';

class JsonExtractionSheet extends StatefulWidget {
  const JsonExtractionSheet({
    super.key,
    required this.isPayload,
    required this.initJsonExtraction,
    required this.initJsonEnable,
    required this.jsonOptionChange,
  });

  final bool isPayload;
  final String? initJsonExtraction;
  final bool? initJsonEnable;
  final Function(String, bool) jsonOptionChange;

  @override
  State<JsonExtractionSheet> createState() => _JsonExtractionSheetState();
}

class _JsonExtractionSheetState extends State<JsonExtractionSheet> {
  late bool enabled;
  late String jsonExtraction;

  @override
  void initState() {
    super.initState();
    enabled = widget.initJsonEnable ?? false;
    jsonExtraction = widget.initJsonExtraction ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        Space.contentPaddingHorizontal.value,
        24,
        Space.contentPaddingHorizontal.value,
        32 + MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: const BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.isPayload ? 'Payload is JSON' : 'Output is JSON',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Switch(
                value: enabled,
                activeColor: const Color(0xfff17d18),
                activeTrackColor: const Color(0xfffab981),
                onChanged: (newEnable) {
                  setState(() {
                    enabled = newEnable;
                  });
                  widget.jsonOptionChange(jsonExtraction, newEnable);
                },
              )
            ],
          ),
          SizedBox(height: Space.contentItemGap.value),
          MyTextField(
            initText: widget.initJsonExtraction,
            labelText: 'Payload path',
            prefixIcon: MyIcon.download.getPath(),
            horizontalPadding: 0,
            enabled: enabled,
            onChanged: (newJsonExtraction) {
              setState(() {
                jsonExtraction = newJsonExtraction;
              });
              widget.jsonOptionChange(newJsonExtraction, enabled);
            },
          ),
          SizedBox(height: Space.contentItemGap.value),
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
