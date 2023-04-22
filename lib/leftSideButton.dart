import 'package:flutter/material.dart';
import 'package:gpt_ihc/globals.dart';

class LeftSideButton extends StatefulWidget {
  const LeftSideButton({Key? key, required this.index, required this.currentIndex, required this.leading, required this.title, required this.verticalPadding, required this.isNewChatButton}) : super(key: key);
  final int index, currentIndex;
  final double verticalPadding;
  final bool isNewChatButton;
  final IconData leading;
  final String title;

  @override
  State<LeftSideButton> createState() => _LeftSideButtonState();
}

class _LeftSideButtonState extends State<LeftSideButton> {

  @override
  Widget build(BuildContext context) {
    BoxDecoration chatHistoryBoxDecoration = BoxDecoration(
      color: widget.currentIndex == widget.index && widget.leading == Icons.chat_bubble_outline?
      leftSideBarHistoryItemHoverColor : Colors.transparent,
    );

    return Padding(
      padding: EdgeInsets.symmetric(vertical: widget.verticalPadding),
      child: Container(
        width: 250,
        height: 47,
        decoration: widget.isNewChatButton? newChatBoxDecoration : chatHistoryBoxDecoration,
        child: RawMaterialButton(
            onPressed: (){},
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(widget.leading,color: Colors.white,size: 16,),
                ),
                Expanded(child: Text(widget.title,style: const TextStyle(color: Colors.white,overflow: TextOverflow.ellipsis),maxLines: 1))
              ],
            )
        ),
      ),
    );
  }
}

