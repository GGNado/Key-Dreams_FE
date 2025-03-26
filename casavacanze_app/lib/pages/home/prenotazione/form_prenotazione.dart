import 'package:casavacanze_app/entity/prenotazione.dart';
import 'package:casavacanze_app/entity/user.dart';
import 'package:casavacanze_app/service/token.dart' as Token;
import 'package:flutter/material.dart';

class FormPrenotazione extends StatefulWidget {
  final int casaVacanzaId;

  const FormPrenotazione({
    Key? key,
    required this.casaVacanzaId,
  }) : super(key: key);

  @override
  State<FormPrenotazione> createState() => _FormPrenotazioneState();
}

class _FormPrenotazioneState extends State<FormPrenotazione> {
  DateTime? _dataInizio;
  DateTime? _dataFine;
  final TextEditingController _personeController = TextEditingController();

  Future<void> _selezionaData({required bool inizio}) async {
    final data = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (data != null) {
      setState(() {
        if (inizio) {
          _dataInizio = data;
        } else {
          _dataFine = data;
        }
      });
    }
  }

  void _inviaPrenotazione() async {
    final token = await Token.getToken();
    User user = User.fromToken(token!);

    if (user.id == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Utente non trovato')),
      );
      return;
    }

    if (_dataInizio != null && _dataFine != null && _personeController.text.isNotEmpty) {
      final prenotazione = Prenotazione(
        id: 0,
        utente: user.id,
        casaVacanza: widget.casaVacanzaId,
        dataInizio: _dataInizio!.millisecondsSinceEpoch,
        dataFine: _dataFine!.millisecondsSinceEpoch,
        numeroPersone: int.tryParse(_personeController.text) ?? 1,
        prezzoTotale: 0,
      );

      //final json = Prenotazione.toJson(prenotazione);
      //debugPrint('Prenotazione da inviare: $json');
      int rs = await prenotazione.inviaPrenotazione(prenotazione, token);

      if (rs == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Prenotazione inviata con successo!')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Errore durante l\'invio')),
        );
      }

      // TODO: invio al backend
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Compila tutti i campi')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prenota')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text(_dataInizio == null
                  ? 'Seleziona data inizio'
                  : 'Inizio: ${_dataInizio!.toLocal().toString().split(' ')[0]}'),
              trailing: const Icon(Icons.calendar_today),
              onTap: () => _selezionaData(inizio: true),
            ),
            ListTile(
              title: Text(_dataFine == null
                  ? 'Seleziona data fine'
                  : 'Fine: ${_dataFine!.toLocal().toString().split(' ')[0]}'),
              trailing: const Icon(Icons.calendar_today),
              onTap: () => _selezionaData(inizio: false),
            ),
            TextField(
              controller: _personeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Numero persone'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _inviaPrenotazione,
              child: const Text('Prenota'),
            ),
          ],
        ),
      ),
    );
  }
}