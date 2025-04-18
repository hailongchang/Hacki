import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacki/cubits/cubits.dart';
import 'package:hacki/extensions/context_extension.dart';
import 'package:hacki/models/models.dart';
import 'package:hacki/screens/widgets/widgets.dart';
import 'package:hacki/utils/utils.dart';

class PinIconButton extends StatelessWidget {
  const PinIconButton({
    required this.story,
    super.key,
  });

  final Story story;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PinCubit, PinState>(
      builder: (BuildContext context, PinState pinState) {
        final bool pinned = pinState.pinnedStoriesIds.contains(story.id);
        return Transform.rotate(
          angle: pi / 4,
          child: Transform.translate(
            offset: const Offset(2, 0),
            child: IconButton(
              tooltip: 'Pin to home screen',
              icon: CustomDescribedFeatureOverlay(
                tapTarget: Icon(
                  pinned ? Icons.push_pin : Icons.push_pin_outlined,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                feature: DiscoverableFeature.pinToTop,
                child: Icon(
                  pinned ? Icons.push_pin : Icons.push_pin_outlined,
                  color: pinned
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              onPressed: () {
                HapticFeedbackUtil.light();
                if (pinned) {
                  context.read<PinCubit>().unpinStory(story);
                } else {
                  context.read<PinCubit>().pinStory(
                        story,
                        onDone: () => context.showSnackBar(
                          content: 'Pinned to home page.',
                        ),
                      );
                }
              },
            ),
          ),
        );
      },
    );
  }
}
