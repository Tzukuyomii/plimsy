import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({
    super.key,
    required this.isEmail,
    required this.onChanged,
  });

  bool isEmail;
  final Function(String) onChanged; // Callback per notificare i cambiamenti

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final TextEditingController _controller = TextEditingController();

  void _submitValue() {
    final enteredValue = _controller.text; // Legge il valore inserito
    print("Valore inserito: $enteredValue");
    // Qui puoi inviare `enteredValue` tramite un servizio HTTP o altro
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) => {widget.onChanged(value)},
      controller: _controller,
      minLines: widget.isEmail ? 1 : 5, // Altezza minima
      maxLines: widget.isEmail ? 1 : null, // Altezza dinamica per testo lungo

      decoration: InputDecoration(
        hintText: widget.isEmail ? "email@example.com" : "...", // Placeholder
        hintStyle: const TextStyle(color: Colors.grey), // Stile del placeholder
        filled: true,
        fillColor: Colors.white, // Sfondo bianco
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // Bordi arrotondati
          borderSide: BorderSide.none, // Nessun bordo visibile
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.blue, // Colore del bordo quando in focus
            width: 2, // Larghezza del bordo in focus
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color:
                Colors.grey.shade300, // Bordo grigio chiaro quando non in focus
            width: 1, // Larghezza del bordo
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 8.0,
        ), // Padding interno
      ),
      keyboardType: widget.isEmail
          ? TextInputType.emailAddress
          : TextInputType.multiline, // Tipo di input email
    );
  }
}
