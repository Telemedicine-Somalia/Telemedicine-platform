
import 'package:flutter/material.dart';

class ReusableCardP extends StatefulWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  final VoidCallback onTap;

  const ReusableCardP({
    super.key,
    required this.icon,
    required this.text,
    required this.iconColor,
    required this.onTap,
  });

  @override
  State<ReusableCardP> createState() => _ReusableCardPState();
}

class _ReusableCardPState extends State<ReusableCardP> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 3,
                  spreadRadius: 1,
                  offset: const Offset(1, 1),
                ),
              ],
            ),
            child: Center(
              child: Icon(widget.icon, size: 30, color: widget.iconColor),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            widget.text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  
  }
}
