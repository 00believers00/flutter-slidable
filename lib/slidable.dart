import 'package:flutter/material.dart';

class Slidable extends StatefulWidget {
  const Slidable({
    Key? key,
    required this.child,
    this.endAction,
    required this.onChangeAction,
    required this.isAction,
    required this.id,
    required this.onPressedAction,
    required this.widthEndAction,
  }) : super(key: key);
  final Widget child;
  final List<Widget>? endAction;
  final ValueChanged<int?> onChangeAction;
  final ValueChanged<int?> onPressedAction;
  final bool isAction;
  final int id;
  final double widthEndAction;

  @override
  State<Slidable> createState() => _SlidableState();
}

class _SlidableState extends State<Slidable> {
  Offset startPosition = Offset.zero;
  Offset endPosition = Offset.zero;
  double slider = 0;
  SlidableActionEventType eventType = SlidableActionEventType.none;

  @override
  Widget build(BuildContext context) {
    checkAction();
    return GestureDetector(
      onPanDown: (_) {
        widget.onChangeAction(widget.id);
      },
      onPanStart: (d) {
        startPosition = d.localPosition;
      },
      onPanUpdate: (d) {
        endPosition = d.localPosition;
        updatePosition();
      },
      onPanEnd: (d) {
        if(eventType == SlidableActionEventType.end){
          openEndAction();
        }else{
          clearAction();
        }
      },
      child: Stack(
        children: [
          Transform.translate(
            offset: Offset(slider, 0),
            child: Container(
              constraints: const BoxConstraints(minWidth: 0, minHeight: 0),
              child: widget.child,
            ),
          ),
          Transform.translate(
            offset: Offset(slider + widget.widthEndAction, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (eventType == SlidableActionEventType.end &&
                    widget.endAction != null)
                  ...List.generate(widget.endAction!.length, (index) {
                    return InkWell(
                      onTap: () {
                        widget.onPressedAction(widget.id);
                      },
                      child: widget.endAction![index],
                    );
                  }),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Future<void> checkAction() async {
    await Future.delayed(const Duration(milliseconds: 50));
    if (!widget.isAction) {
      if (startPosition != Offset.zero || endPosition != Offset.zero) {
        clearPosition();
      }
    }
  }

  void clearPosition() {
    startPosition = Offset.zero;
    endPosition = Offset.zero;
    updatePosition();
  }

  void updatePosition() {
    slider = endPosition.dx - startPosition.dx;
    if (slider < (-widget.widthEndAction/4) * 3) {
      openEndAction();
      return;
    } else if (slider >= 0) {
      clearAction();
    }

    if (slider < 0) {
      eventType = SlidableActionEventType.end;
    }

    updateScreen();
  }

  void openEndAction(){
    slider = -widget.widthEndAction;
    eventType = SlidableActionEventType.end;
    updateScreen();
  }

  void clearAction(){
    slider = 0;
    eventType = SlidableActionEventType.none;
  }

  void updateScreen() {
    if (mounted) {
      setState(() {});
    }
  }
}

enum SlidableActionEventType { start, end, none }
