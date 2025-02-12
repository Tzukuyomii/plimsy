import 'package:flutter/material.dart';

class TableFixed extends StatefulWidget {
  const TableFixed({super.key, required this.initialData});

  final List<dynamic> initialData; // Dati dal servizio
  @override
  State<StatefulWidget> createState() {
    return _TableFixed();
  }
}

class _TableFixed extends State<TableFixed> {
  List<dynamic> rows = [];

  @override
  void initState() {
    super.initState();

    // Inizializza 'rows' con i dati ricevuti, creando i controller per ogni campo
    rows = widget.initialData.map((item) {
      return {
        'id': item['id'],
        'description': TextEditingController(text: item['description']),
        'weight': TextEditingController(text: item['weight']),
        'lcg': TextEditingController(text: item['lcg']),
        'tcg': TextEditingController(text: item['tcg']),
        'vcg': TextEditingController(text: item['vcg']),
        'notes': TextEditingController(text: item['notes']),
      };
    }).toList();

    print("Lista ${widget.initialData}");
  }

  void addRow(int index) {
    setState(() {
      rows.insert(index, {
        'id': rows.length + 1, // Usa un ID incrementale
        'description': TextEditingController(),
        'weight': TextEditingController(),
        'lcg': TextEditingController(),
        'tcg': TextEditingController(),
        'vcg': TextEditingController(),
        'notes': TextEditingController(),
      });
    });
  }

  void removeRow(int index) {
    setState(() {
      // Rimuovi i controller della riga eliminata
      rows[index]['description'].dispose();
      rows[index]['weight'].dispose();
      rows[index]['lcg'].dispose();
      rows[index]['tcg'].dispose();
      rows[index]['vcg'].dispose();
      rows[index]['notes'].dispose();

      rows.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.2,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          horizontalMargin: 5,
          columnSpacing: 0,
          columns: [
            DataColumn(
                label: SizedBox(width: width * 0.001, child: const Text(''))),
            DataColumn(
              label: SizedBox(
                width: width * 0.06,
                child: Text(
                  'Description',
                  style: TextStyle(color: Colors.white, fontSize: width * 0.01),
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Weight (tons)',
                style: TextStyle(color: Colors.white, fontSize: width * 0.01),
              ),
            ),
            DataColumn(
                label: Text(
              'LCG (m)',
              style: TextStyle(color: Colors.white, fontSize: width * 0.01),
            )),
            DataColumn(
                label: Text(
              'TCG (m)',
              style: TextStyle(color: Colors.white, fontSize: width * 0.01),
            )),
            DataColumn(
                label: Text(
              'VCG (m)',
              style: TextStyle(color: Colors.white, fontSize: width * 0.01),
            )),
            DataColumn(
                label: Text(
              'Notes',
              style: TextStyle(color: Colors.white, fontSize: width * 0.01),
            )),
            DataColumn(label: Text('')),
          ],
          rows: List<DataRow>.generate(
            rows.length,
            (index) {
              final row = rows[index];
              return DataRow(
                key: ValueKey(index), // Usa una chiave unica
                cells: [
                  DataCell(Text(
                    (index + 1).toString(),
                    style:
                        TextStyle(color: Colors.white, fontSize: width * 0.01),
                  )),
                  DataCell(
                    SizedBox(
                      width: width * 0.05,
                      height: height * 0.05,
                      child: TextField(
                        controller: row['description'], // Usa il controller
                        onChanged: (value) {
                          setState(() {
                            row['description'].text = value;
                            if (value.isNotEmpty && index == rows.length - 1) {
                              addRow(index + 1);
                            }
                          });
                        },
                        cursorColor: Colors.white,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * 0.01,
                        ),
                        maxLines: 1,
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                      ),
                    ),
                  ),
                  DataCell(
                    SizedBox(
                      width: width * 0.05,
                      height: height * 0.05,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: row['weight'], // Usa il controller
                        onChanged: (value) {
                          setState(() {
                            row['weight'].text = value;
                          });
                        },
                        maxLines: 1,
                        cursorColor: Colors.white,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * 0.01,
                        ),
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                      ),
                    ),
                  ),
                  DataCell(
                    SizedBox(
                      width: width * 0.04,
                      height: height * 0.05,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: row['lcg'], // Usa il controller
                        readOnly: true,
                        onChanged: (value) {
                          setState(() {
                            row['lcg'].text = value;
                          });
                        },
                        maxLines: 1,
                        cursorColor: Colors.white,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * 0.01,
                        ),
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                      ),
                    ),
                  ),
                  DataCell(
                    SizedBox(
                      width: width * 0.04,
                      height: height * 0.05,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: row['tcg'], // Usa il controller
                        readOnly: true,
                        onChanged: (value) {
                          setState(() {
                            row['tcg'].text = value;
                          });
                        },
                        maxLines: 1,
                        cursorColor: Colors.white,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * 0.01,
                        ),
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                      ),
                    ),
                  ),
                  DataCell(
                    SizedBox(
                      width: width * 0.04,
                      height: height * 0.05,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: row['vcg'], // Usa il controller
                        readOnly: true,
                        onChanged: (value) {
                          setState(() {
                            row['vcg'].text = value;
                          });
                        },
                        maxLines: 1,
                        cursorColor: Colors.white,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * 0.01,
                        ),
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                      ),
                    ),
                  ),
                  DataCell(
                    SizedBox(
                      width: width * 0.05,
                      height: height * 0.05,
                      child: TextField(
                        controller: row['notes'], // Usa il controller
                        onChanged: (value) {
                          setState(() {
                            row['notes'].text = value;
                          });
                        },
                        maxLines: 1,
                        cursorColor: Colors.white,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * 0.01,
                        ),
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                      ),
                    ),
                  ),
                  DataCell(IconButton(
                    icon: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Icon(Icons.delete_forever,
                            color: Colors.white)),
                    onPressed: () => removeRow(index),
                  )),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
