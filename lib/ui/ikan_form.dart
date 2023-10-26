import 'package:flutter/material.dart';
import 'package:tokokita/bloc/ikan_bloc.dart';
import 'package:tokokita/model/ikan.dart';
import 'package:tokokita/ui/ikan_page.dart';
import 'package:tokokita/widget/warning_dialog.dart';

class IkanForm extends StatefulWidget {
  final Ikan? ikan;

  const IkanForm({Key? key, this.ikan}) : super(key: key);

  @override
  _IkanFormState createState() => _IkanFormState();
}

class _IkanFormState extends State<IkanForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH IKAN";
  String tombolSubmit = "SIMPAN";

  final _namaIkanTextboxController = TextEditingController();
  final _jenisTextboxController = TextEditingController();
  final _warnaTextboxController = TextEditingController();
  final _habitatTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.ikan != null) {
      setState(() {
        judul = "UBAH IKAN";
        tombolSubmit = "UBAH";
        _namaIkanTextboxController.text = widget.ikan!.namaIkan!;
        _jenisTextboxController.text = widget.ikan!.jenis!;
        _warnaTextboxController.text = widget.ikan!.warna!;
        _habitatTextboxController.text = widget.ikan!.habitat!;
      });
    } else {
      judul = "TAMBAH IKAN";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTextFormField("Nama ikan", _namaIkanTextboxController),
                _buildTextFormField("Jenis", _jenisTextboxController),
                _buildTextFormField("Warna", _warnaTextboxController),
                _buildTextFormField("Habitat", _habitatTextboxController),
                const SizedBox(height: 20),
                _buildButtonSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(String label, TextEditingController controller) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.text,
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return "$label harus diisi";
        }
        return null;
      },
    );
  }

  Widget _buildButtonSubmit() {
    return ElevatedButton(
      child: _isLoading
          ? const SizedBox(
              height: 20.0,
              width: 20.0,
              child: CircularProgressIndicator(color: Colors.white),
            )
          : Text(tombolSubmit),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate && !_isLoading) {
          if (widget.ikan != null) {
            ubah();
          } else {
            simpan();
          }
        }
      },
    );
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    Ikan createIkan = Ikan(id: null);

    createIkan.namaIkan = _namaIkanTextboxController.text;
    createIkan.jenis = _jenisTextboxController.text;
    createIkan.warna = _warnaTextboxController.text;
    createIkan.habitat = _habitatTextboxController.text;
    IkanBloc.addIkan(ikan: createIkan).then((value) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => const IkanPage(),
        ),
      );
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Simpan gagal, silahkan coba lagi",
        ),
      );
    });
    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    Ikan updateIkan = Ikan(id: null);
    updateIkan.id = widget.ikan!.id;
    updateIkan.namaIkan = _namaIkanTextboxController.text;
    updateIkan.jenis = _jenisTextboxController.text;
    updateIkan.warna = _warnaTextboxController.text;
    updateIkan.habitat = _habitatTextboxController.text;
    IkanBloc.updateIkan(ikan: updateIkan).then((value) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => const IkanPage(),
        ),
      );
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Permintaan ubah data gagal, silahkan coba lagi",
        ),
      );
    });
    setState(() {
      _isLoading = false;
    });
  }
}
