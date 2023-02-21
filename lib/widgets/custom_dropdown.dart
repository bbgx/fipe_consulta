import 'package:fipez/models/fipe_request.dart';
import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';

class CustomDropdown extends StatefulWidget{
  final String label;
  final String? value;
  final bool disabled;
  final Function(String? value) onChange;
  final List<FipeRequest>? items;
  
  const CustomDropdown({Key? key, required this.label, required this.value, this.disabled = false, required this.onChange, required this.items})
      : super(key: key); 
  
  @override
  _CustomDropdownState createState() => _CustomDropdownState();   
}

class _CustomDropdownState extends State<CustomDropdown>{

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Column(children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 33.0),
        alignment: Alignment.topLeft,
        child: Text(
          widget.label,
          style: TextStyle(color: Colors.grey[700], fontSize: 16),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35.0),
        child: SearchChoices.single(
          isExpanded: true,
          value: widget.value,        
          readOnly: widget.disabled,
          displayClearIcon: false,
          padding: 7,
          onChanged: (newValue) {
            widget.onChange(newValue); 
          },
          searchFn: (String keyword, items){
            List<int> ret = [];
            if (items != null && keyword.isNotEmpty) {
              keyword.split(" ").forEach((k) {
                int index = 0;
                items.forEach((item) {
                  if (!ret.contains(index) &&
                      k.isNotEmpty &&
                      (item.child.data
                        .toString()
                        .toLowerCase()
                        .contains(k.toLowerCase()))) {
                          ret.add(index);
                  }
                index++;
              });
            });
            }
            if (keyword.isEmpty) {
              ret = Iterable<int>.generate(items.length).toList();
            }
              return (ret);
          },
          items: widget.items != null
                      ? widget.items?.map((item) {
                          return DropdownMenuItem(
                            value: item.codigo,
                            child: Text(item.nome),
                          );
                        }).toList()
                      : []
        ),
      ),
      const SizedBox(
        height: 10,
      ),
    ]); 
  }
}
