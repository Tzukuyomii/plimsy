import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({
    super.key,
    required this.isEmail,
    required this.onChanged,
  });

  final bool isEmail;
  final Function(String) onChanged; // Callback per notificare i cambiamenti

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final TextEditingController _controller = TextEditingController();
  String? _errorText;

  // Metodo per validare l'email
  bool _validateEmail(String value) {
    // Regex per email che termina con .it o .com
    final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.(it|com)$");
    return emailRegex.hasMatch(value);
  }

  void _onChanged(String value) {
    if (widget.isEmail) {
      setState(() {
        if (_validateEmail(value)) {
          _errorText = null; // Email valida
        } else {
          _errorText = "Inserisci un'email valida (es: email@esempio.it)";
        }
      });
    }
    widget.onChanged(value); // Notifica il valore cambiato
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          onChanged: _onChanged,
          controller: _controller,
          minLines: widget.isEmail ? 1 : 5, // Altezza minima
          maxLines:
              widget.isEmail ? 1 : null, // Altezza dinamica per testo lungo
          decoration: InputDecoration(
            hintText:
                widget.isEmail ? "email@example.com" : "...", // Placeholder
            hintStyle:
                const TextStyle(color: Colors.grey), // Stile del placeholder
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
                color: Colors
                    .grey.shade300, // Bordo grigio chiaro quando non in focus
                width: 1, // Larghezza del bordo
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 8.0,
            ), // Padding interno
            errorText: _errorText, // Mostra il messaggio di errore se presente
          ),
          keyboardType: widget.isEmail
              ? TextInputType.emailAddress
              : TextInputType.multiline, // Tipo di input email
        ),
      ],
    );
  }
}
