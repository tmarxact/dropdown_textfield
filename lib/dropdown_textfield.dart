import 'dart:async';

import 'package:collection/collection.dart';
import 'package:dropdown_textfield/tooltip_widget.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class IconProperty {
  final IconData? icon;
  final Color? color;
  final double? size;
  IconProperty({this.icon, this.color, this.size});
}

class CheckBoxProperty {
  final MouseCursor? mouseCursor;
  final Color? activeColor;
  final MaterialStateProperty<Color?>? fillColor;
  final Color? checkColor;
  final bool tristate;
  final MaterialTapTargetSize? materialTapTargetSize;
  final VisualDensity? visualDensity;
  final Color? focusColor;
  final Color? hoverColor;
  final MaterialStateProperty<Color?>? overlayColor;
  final double? splashRadius;
  final bool autofocus;
  final OutlinedBorder? shape;
  final BorderSide? side;
  static const double width = 18.0;
  CheckBoxProperty({
    this.tristate = false,
    this.mouseCursor,
    this.activeColor,
    this.fillColor,
    this.checkColor,
    this.focusColor,
    this.hoverColor,
    this.overlayColor,
    this.splashRadius,
    this.materialTapTargetSize,
    this.visualDensity,
    this.autofocus = false,
    this.shape,
    this.side,
  });
}

class DropDownTextField extends StatefulWidget {
  const DropDownTextField(
      {Key? key,
      this.controller,
      this.initialValue,
      required this.dropDownList,
      this.padding,
      this.textStyle,
      this.onChanged,
      this.validator,
      this.isEnabled = true,
      this.enableSearch = false,
      this.readOnly = true,
      this.dropdownRadius = 12,
      this.textFieldDecoration,
      this.dropDownIconProperty,
      this.dropDownItemCount = 6,
      this.searchAutofocus = false,
      this.searchDecoration,
      this.searchShowCursor,
      this.searchKeyboardType,
      this.listSpace = 0,
      this.clearOption = true,
      this.clearIconProperty,
      this.listPadding,
      this.listTextStyle,
      this.keyboardType,
      this.autovalidateMode})
      : assert(
          !(initialValue != null && controller != null),
          "you cannot add both initialValue and singleController,\nset initial value using controller \n\tEg: SingleValueDropDownController(data:initial value) ",
        ),
        assert(!(!readOnly && enableSearch),
            "readOnly!=true or enableSearch=true both condition does not work"),
        assert(
          !(controller != null &&
              !(controller is SingleValueDropDownController)),
          "controller must be type of SingleValueDropDownController",
        ),
        checkBoxProperty = null,
        isMultiSelection = false,
        singleController = controller,
        multiController = null,
        displayCompleteItem = false,
        submitButtonColor = null,
        submitButtonText = null,
        submitButtonTextStyle = null,
        super(key: key);
  const DropDownTextField.multiSelection(
      {Key? key,
      this.controller,
      this.displayCompleteItem = false,
      this.initialValue,
      required this.dropDownList,
      this.padding,
      this.textStyle,
      this.onChanged,
      this.validator,
      this.isEnabled = true,
      this.dropdownRadius = 12,
      this.dropDownIconProperty,
      this.textFieldDecoration,
      this.dropDownItemCount = 6,
      this.listSpace = 0,
      this.clearOption = true,
      this.clearIconProperty,
      this.submitButtonColor,
      this.submitButtonText,
      this.submitButtonTextStyle,
      this.listPadding,
      this.listTextStyle,
      this.checkBoxProperty,
      this.autovalidateMode})
      : assert(initialValue == null || controller == null,
            "you cannot add both initialValue and multiController\nset initial value using controller\n\tMultiValueDropDownController(data:initial value)"),
        assert(
          !(controller != null &&
              !(controller is MultiValueDropDownController)),
          "controller must be type of MultiValueDropDownController",
        ),
        multiController = controller,
        isMultiSelection = true,
        enableSearch = false,
        readOnly = true,
        searchAutofocus = false,
        searchKeyboardType = null,
        searchShowCursor = null,
        singleController = null,
        searchDecoration = null,
        keyboardType = null,
        // keyboardHeight = 0,
        super(key: key);

  ///single and multiple dropdown controller.
  ///It must be type of SingleValueDropDownController or MultiValueDropDownController.
  final dynamic controller;

  ///single dropdown controller,
  final SingleValueDropDownController? singleController;

  ///multi dropdown controller
  final MultiValueDropDownController? multiController;

  ///define the radius of dropdown List ,default value is 12
  final double dropdownRadius;

  ///initial value ,if it is null or not exist in dropDownList then it will not display value.
  final dynamic initialValue;

  ///dropDownList,List of dropdown values
  ///List<DropDownValueModel>
  final List<DropDownValueModel> dropDownList;

  ///function,called when value selected from dropdown.
  ///for single Selection Dropdown it will return single DropDownValueModel object,
  ///and for multi Selection Dropdown ,it will return list of DropDownValueModel object,
  final ValueSetter? onChanged;

  final bool isMultiSelection;

  final TextStyle? textStyle;

  final EdgeInsets? padding;

  ///override default textfield decoration
  final InputDecoration? textFieldDecoration;

  ///customize dropdown icon size and color
  final IconProperty? dropDownIconProperty;

  ///by setting isEnabled=false to disable textfield,default value true
  final bool isEnabled;

  final FormFieldValidator<String>? validator;

  ///by setting enableSearch=true enable search option in dropdown,as of now this feature enabled only for single selection dropdown
  final bool enableSearch;

  final bool readOnly;

  ///set displayCompleteItem=true, if you want show complete list of item in textfield else it will display like "number_of_item item selected"
  final bool displayCompleteItem;

  ///Maximum number of dropdown item to display,default value is 6
  final int dropDownItemCount;

  ///override default search decoration
  final InputDecoration? searchDecoration;

  ///override default search keyboard type,only applicable if enableSearch=true,
  final TextInputType? searchKeyboardType;

  ///by setting searchAutofocus=true to autofocus search textfield,only applicable if enableSearch=true,
  ///  ///default value is false
  final bool searchAutofocus;

  ///by setting searchShowCursor=false to hide cursor from search textfield,only applicable if enableSearch=true,
  final bool? searchShowCursor;

  ///by set clearOption=false to hide clear suffix icon button from textfield.
  final bool clearOption;

  ///customize Clear icon size and color
  final IconProperty? clearIconProperty;

  ///space between textfield and list ,default value is 0
  final double listSpace;

  ///dropdown List item padding
  final ListPadding? listPadding;

  ///multi dropdown submit button text
  final String? submitButtonText;

  ///multi dropdown submit button color
  final Color? submitButtonColor;

  ///multi dropdown submit button text style
  final TextStyle? submitButtonTextStyle;

  ///dropdown list item text style
  final TextStyle? listTextStyle;

  final TextInputType? keyboardType;
  final AutovalidateMode? autovalidateMode;

  ///customize checkbox property
  final CheckBoxProperty? checkBoxProperty;

  @override
  _DropDownTextFieldState createState() => _DropDownTextFieldState();
}

class _DropDownTextFieldState extends State<DropDownTextField>
    with TickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);

  late TextEditingController _cnt;
  late String _hintText;

  late bool _isExpanded;
  OverlayEntry? _entry;
  OverlayEntry? _entry2;
  OverlayEntry? _barrierOverlay;
  final _layerLink = LayerLink();
  late AnimationController _controller;
  late Animation<double> _heightFactor;
  List<bool> _multiSelectionValue = [];
  // late String selectedItem;
  late double _height;
  late List<DropDownValueModel> _dropDownList;
  late int _maxListItem;
  late double _searchWidgetHeight;
  late bool _isOutsideClickOverlay;
  late bool _isScrollPadding;
  final int _duration = 150;
  late Offset _offset;
  late bool _searchAutofocus;
  late bool _isPortrait;
  late double _listTileHeight;
  late double _keyboardHeight;
  late TextStyle _listTileTextStyle;
  late ListPadding _listPadding;
  @override
  void initState() {
    _cnt = TextEditingController();
    _keyboardHeight = 450;
    _searchAutofocus = false;
    _isScrollPadding = false;
    _isOutsideClickOverlay = false;
    _isExpanded = false;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _duration),
    );
    _heightFactor = _controller.drive(_easeInTween);
    _searchWidgetHeight = 60;
    _hintText = "Select Item";

    for (int i = 0; i < widget.dropDownList.length; i++) {
      _multiSelectionValue.add(false);
    }

    ///initial value load
    if (widget.initialValue != null) {
      _dropDownList = List.from(widget.dropDownList);
      if (widget.isMultiSelection) {
        for (int i = 0; i < widget.initialValue.length; i++) {
          var index = _dropDownList.indexWhere((element) =>
              element.name.trim() == widget.initialValue[i].trim());
          if (index != -1) {
            _multiSelectionValue[index] = true;
          }
        }
        int count =
            _multiSelectionValue.where((element) => element).toList().length;

        _cnt.text = (count == 0
            ? ""
            : widget.displayCompleteItem
                ? widget.initialValue.join(",")
                : "$count item selected");
      } else {
        var index = _dropDownList.indexWhere(
            (element) => element.name.trim() == widget.initialValue.trim());

        if (index != -1) {
          _cnt.text = widget.initialValue;
        }
      }
    }
    updateFunction();
    super.initState();
  }

  Size _textWidgetSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  updateFunction({DropDownTextField? oldWidget}) {
    Function eq = const DeepCollectionEquality().equals;
    _dropDownList = List.from(widget.dropDownList);
    _listPadding = widget.listPadding ?? ListPadding();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.isMultiSelection) {
        if (oldWidget != null && !eq(oldWidget.dropDownList, _dropDownList)) {
          _multiSelectionValue = [];
          _cnt.text = "";
          for (int i = 0; i < _dropDownList.length; i++) {
            _multiSelectionValue.add(false);
          }
        }
        // if (widget.isForceMultiSelectionClear &&
        //     _multiSelectionValue.isNotEmpty) {
        //   _multiSelectionValue = [];
        //   _cnt.text = "";
        //   for (int i = 0; i < _dropDownList.length; i++) {
        //     _multiSelectionValue.add(false);
        //   }
        // }

        // if (widget.multiController != null) {
        //   List<DropDownValueModel> multiCnt = [];
        //   for (int i = 0; i < dropDownList.length; i++) {
        //     if (multiSelectionValue[i]) {
        //       multiCnt.add(dropDownList[i]);
        //     }
        //   }
        //   widget.multiController!
        //       .setDropDown(multiCnt.isNotEmpty ? multiCnt : null);
        // }

        if (widget.multiController != null) {
          if (oldWidget != null &&
              oldWidget.multiController!.dropDownValueList != null) {}
          if (widget.multiController!.dropDownValueList != null) {
            _multiSelectionValue = [];
            for (int i = 0; i < _dropDownList.length; i++) {
              _multiSelectionValue.add(false);
            }
            for (int i = 0;
                i < widget.multiController!.dropDownValueList!.length;
                i++) {
              var index = _dropDownList.indexWhere((element) =>
                  element == widget.multiController!.dropDownValueList![i]);
              if (index != -1) {
                _multiSelectionValue[index] = true;
              }
            }
            int count = _multiSelectionValue
                .where((element) => element)
                .toList()
                .length;
            _cnt.text = (count == 0
                ? ""
                : widget.displayCompleteItem
                    ? widget.initialValue.join(",")
                    : "$count item selected");
          } else {
            _multiSelectionValue = [];
            _cnt.text = "";
            for (int i = 0; i < _dropDownList.length; i++) {
              _multiSelectionValue.add(false);
            }
          }
        }
      } else {
        if (widget.singleController != null) {
          if (widget.singleController!.dropDownValue != null) {
            _cnt.text = widget.singleController!.dropDownValue!.name;
          } else {
            _cnt.clear();
          }
        }
      }

      _listTileTextStyle =
          (widget.listTextStyle ?? Theme.of(context).textTheme.subtitle1)!;
      _listTileHeight =
          _textWidgetSize("dummy Text", _listTileTextStyle).height +
              _listPadding.top +
              _listPadding.bottom;
      _maxListItem = widget.dropDownItemCount;

      _height = (!widget.isMultiSelection
              ? (_dropDownList.length < _maxListItem
                  ? _dropDownList.length * _listTileHeight
                  : _listTileHeight * _maxListItem.toDouble())
              : _dropDownList.length < _maxListItem
                  ? _dropDownList.length * _listTileHeight
                  : _listTileHeight * _maxListItem.toDouble()) +
          10;
    });
  }

  @override
  void didUpdateWidget(covariant DropDownTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateFunction(oldWidget: oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    _cnt.dispose();
    super.dispose();
  }

  clearFun() {
    if (_isExpanded) {
      _isExpanded = !_isExpanded;
      hideOverlay();
    }
    _cnt.clear();
    if (widget.isMultiSelection) {
      if (widget.multiController != null) {
        widget.multiController!.setDropDown(null);
      }
      if (widget.onChanged != null) {
        widget.onChanged!([]);
      }

      _multiSelectionValue = [];
      for (int i = 0; i < _dropDownList.length; i++) {
        _multiSelectionValue.add(false);
      }
    } else {
      if (widget.singleController != null) {
        widget.singleController!.setDropDown(null);
      }
      if (widget.onChanged != null) {
        widget.onChanged!("");
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        if (!isKeyboardVisible && _isExpanded && _isScrollPadding) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            shiftOverlayEntry2to1();
          });
        }
        return CompositedTransformTarget(
          link: _layerLink,
          child: TextFormField(
            controller: _cnt,
            keyboardType: widget.keyboardType,
            autovalidateMode: widget.autovalidateMode,
            style: widget.textStyle,
            enabled: widget.isEnabled,
            readOnly: widget.readOnly,
            onTap: () {
              _searchAutofocus = widget.searchAutofocus;
              if (!_isExpanded) {
                if (_dropDownList.isNotEmpty) {
                  _showOverlay();
                }
              } else {
                if (widget.readOnly) hideOverlay();
              }
            },
            validator: (value) =>
                widget.validator != null ? widget.validator!(value) : null,
            decoration: widget.textFieldDecoration != null
                ? widget.textFieldDecoration!.copyWith(
                    suffixIcon: (_cnt.text.isEmpty || !widget.clearOption)
                        ? Icon(
                            widget.dropDownIconProperty?.icon ??
                                Icons.arrow_drop_down_outlined,
                            size: widget.dropDownIconProperty?.size,
                            color: widget.dropDownIconProperty?.color,
                          )
                        : widget.clearOption
                            ? InkWell(
                                onTap: clearFun,
                                child: Icon(
                                  widget.clearIconProperty?.icon ?? Icons.clear,
                                  size: widget.clearIconProperty?.size,
                                  color: widget.clearIconProperty?.color,
                                ),
                              )
                            : null,
                  )
                : InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: _hintText,
                    hintStyle: const TextStyle(fontWeight: FontWeight.normal),
                    suffixIcon: (_cnt.text.isEmpty || !widget.clearOption)
                        ? Icon(
                            widget.dropDownIconProperty?.icon ??
                                Icons.arrow_drop_down_outlined,
                            size: widget.dropDownIconProperty?.size,
                            color: widget.dropDownIconProperty?.color,
                          )
                        : widget.clearOption
                            ? InkWell(
                                onTap: clearFun,
                                child: Icon(
                                  widget.clearIconProperty?.icon ?? Icons.clear,
                                  size: widget.clearIconProperty?.size,
                                  color: widget.clearIconProperty?.color,
                                ),
                              )
                            : null,
                  ),
          ),
        );
      },
    );
  }

  Future<void> _showOverlay() async {
    if (mounted) {
      _controller.forward();
    }
    _isExpanded = true;
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    _offset = renderBox.localToGlobal(Offset.zero);
    double posFromTop = _offset.dy;
    double posFromBot = MediaQuery.of(context).size.height - posFromTop;

    double dropdownListHeight = _height +
        (widget.enableSearch ? _searchWidgetHeight : 0) +
        widget.listSpace;
    double ht = dropdownListHeight + 120;
    if (_searchAutofocus &&
        !(posFromBot < ht) &&
        posFromBot < _keyboardHeight &&
        !_isScrollPadding &&
        _isPortrait) {
      _isScrollPadding = true;
    }
    _isOutsideClickOverlay = _isScrollPadding ||
        (widget.readOnly &&
            dropdownListHeight >
                (posFromTop - MediaQuery.of(context).padding.top - 15) &&
            posFromBot < ht);
    final double topPaddingHeight = _isOutsideClickOverlay
        ? (dropdownListHeight -
            (posFromTop - MediaQuery.of(context).padding.top - 15))
        : 0;

    final double htPos = posFromBot < ht
        ? size.height - 100 + topPaddingHeight
        : _isScrollPadding
            ? size.height - (_keyboardHeight - posFromBot)
            : size.height;
    if (_isOutsideClickOverlay) {
      _openOutSideClickOverlay(context);
    }
    _entry = OverlayEntry(
      builder: (context) => Positioned(
          width: size.width,
          child: CompositedTransformFollower(
              targetAnchor: posFromBot < ht
                  ? Alignment.bottomCenter
                  : Alignment.topCenter,
              followerAnchor: posFromBot < ht
                  ? Alignment.bottomCenter
                  : Alignment.topCenter,
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(
                0,
                posFromBot < ht
                    ? htPos - widget.listSpace
                    : htPos + widget.listSpace,
              ),
              child: AnimatedBuilder(
                animation: _controller.view,
                builder: buildOverlay,
              ))),
    );
    _entry2 = OverlayEntry(
      builder: (context) => Positioned(
          width: size.width,
          child: CompositedTransformFollower(
              targetAnchor: Alignment.bottomCenter,
              followerAnchor: Alignment.bottomCenter,
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(
                0,
                htPos,
              ),
              child: AnimatedBuilder(
                animation: _controller.view,
                builder: buildOverlay,
              ))),
    );
    overlay.insert(_isScrollPadding ? _entry2! : _entry!);
  }

  _openOutSideClickOverlay(BuildContext context) {
    final overlay2 = Overlay.of(context);
    _barrierOverlay = OverlayEntry(builder: (context) {
      final size = MediaQuery.of(context).size;
      return GestureDetector(
        onTap: () {
          hideOverlay();
        },
        child: Container(
          width: size.width,
          height: size.height,
          color: Colors.transparent,
        ),
      );
    });
    overlay2.insert(_barrierOverlay!);
  }

  void hideOverlay() {
    if (!_isScrollPadding) {}
    if (mounted) {
      _controller.reverse().then<void>((void value) {
        if (_entry != null && _entry!.mounted) {
          _entry?.remove();
          _entry = null;
        }
        if (_entry2 != null && _entry2!.mounted) {
          _entry2?.remove();
          _entry2 = null;
        }

        if (_barrierOverlay != null && _barrierOverlay!.mounted) {
          _barrierOverlay?.remove();
          _barrierOverlay = null;
          _isOutsideClickOverlay = false;
        }
        _isScrollPadding = false;
        _isExpanded = false;
      });
    }
  }

  void shiftOverlayEntry1to2() {
    _entry?.remove();
    _entry = null;
    if (_barrierOverlay != null && _barrierOverlay!.mounted) {
      _barrierOverlay?.remove();
      _barrierOverlay = null;
      _isOutsideClickOverlay = false;
    }
    _isScrollPadding = true;
    _showOverlay();
  }

  void shiftOverlayEntry2to1() {
    _searchAutofocus = false;
    _entry2?.remove();
    _entry2 = null;
    if (_barrierOverlay != null && _barrierOverlay!.mounted) {
      _barrierOverlay?.remove();
      _barrierOverlay = null;
      _isOutsideClickOverlay = false;
    }
    if (mounted) {
      _controller.reset();
    }
    _isScrollPadding = false;
    _showOverlay();
  }

  Widget buildOverlay(context, child) {
    return ClipRect(
      child: Align(
        heightFactor: _heightFactor.value,
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.all(Radius.circular(widget.dropdownRadius)),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: !widget.isMultiSelection
                  ? SingleSelection(
                      mainController: _cnt,
                      autoSort: !widget.readOnly,
                      enableSearch: widget.enableSearch,
                      height: _height,
                      listTileHeight: _listTileHeight,
                      dropDownList: _dropDownList,
                      listTextStyle: _listTileTextStyle,
                      onChanged: (item) {
                        setState(() {
                          _cnt.text = item.name;
                          _isExpanded = !_isExpanded;
                        });
                        if (widget.singleController != null) {
                          widget.singleController!.setDropDown(item);
                        }
                        if (widget.onChanged != null) {
                          widget.onChanged!(item);
                        }
                        // Navigator.pop(context, null);

                        hideOverlay();
                      },
                      searchHeight: _searchWidgetHeight,
                      searchKeyboardType: widget.searchKeyboardType,
                      searchAutofocus: _searchAutofocus,
                      searchDecoration: widget.searchDecoration,
                      searchShowCursor: widget.searchShowCursor,
                      listPadding: _listPadding,
                      // onSearchTap: () {
                      //   double posFromBot =
                      //       MediaQuery.of(context).size.height - _offset.dy;
                      //   if (posFromBot < _keyboardHeight &&
                      //       !_isScrollPadding &&
                      //       _isPortrait) {
                      //     shiftOverlayEntry1to2();
                      //   }
                      // },
                      // onSearchSubmit: () {
                      //   if (_isScrollPadding) {
                      //     shiftOverlayEntry2to1();
                      //   }
                      // },
                      clearIconProperty: widget.clearIconProperty,
                    )
                  : MultiSelection(
                      buttonTextStyle: widget.submitButtonTextStyle,
                      buttonText: widget.submitButtonText,
                      buttonColor: widget.submitButtonColor,
                      height: _height,
                      listTileHeight: _listTileHeight,
                      list: _multiSelectionValue,
                      dropDownList: _dropDownList,
                      listTextStyle: _listTileTextStyle,
                      listPadding: _listPadding,
                      onChanged: (val) {
                        _isExpanded = !_isExpanded;
                        _multiSelectionValue = val;
                        List<DropDownValueModel> result = [];
                        List completeList = [];
                        for (int i = 0; i < _multiSelectionValue.length; i++) {
                          if (_multiSelectionValue[i]) {
                            result.add(_dropDownList[i]);
                            completeList.add(_dropDownList[i].name);
                          }
                        }
                        int count = _multiSelectionValue
                            .where((element) => element)
                            .toList()
                            .length;

                        _cnt.text = (count == 0
                            ? ""
                            : widget.displayCompleteItem
                                ? completeList.join(",")
                                : "$count item selected");
                        if (widget.multiController != null) {
                          widget.multiController!
                              .setDropDown(result.isNotEmpty ? result : null);
                        }
                        if (widget.onChanged != null) {
                          widget.onChanged!(result);
                        }

                        hideOverlay();

                        setState(() {});
                      },
                      checkBoxProperty: widget.checkBoxProperty,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class SingleSelection extends StatefulWidget {
  const SingleSelection({
    Key? key,
    required this.dropDownList,
    required this.onChanged,
    required this.height,
    required this.enableSearch,
    this.searchKeyboardType,
    required this.searchAutofocus,
    this.searchShowCursor,
    required this.mainController,
    required this.autoSort,
    required this.listTileHeight,
    this.onSearchTap,
    this.onSearchSubmit,
    this.listTextStyle,
    this.searchDecoration,
    required this.listPadding,
    this.clearIconProperty,
    required this.searchHeight,
  }) : super(key: key);
  final List<DropDownValueModel> dropDownList;
  final ValueSetter onChanged;
  final double height;
  final double listTileHeight;
  final bool enableSearch;
  final double searchHeight;
  final TextInputType? searchKeyboardType;
  final bool searchAutofocus;
  final bool? searchShowCursor;
  final TextEditingController mainController;
  final bool autoSort;
  final Function? onSearchTap;
  final Function? onSearchSubmit;
  final TextStyle? listTextStyle;
  final ListPadding listPadding;
  final InputDecoration? searchDecoration;
  final IconProperty? clearIconProperty;

  @override
  State<SingleSelection> createState() => _SingleSelectionState();
}

class _SingleSelectionState extends State<SingleSelection> {
  late List<DropDownValueModel> newDropDownList;
  late TextEditingController _searchCnt;
  late InputDecoration _inpDec;
  onItemChanged(String value) {
    setState(() {
      if (value.isEmpty) {
        newDropDownList = List.from(widget.dropDownList);
      } else {
        newDropDownList = widget.dropDownList
            .where(
                (item) => item.name.toLowerCase().contains(value.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  void initState() {
    _inpDec = widget.searchDecoration ?? InputDecoration();

    newDropDownList = List.from(widget.dropDownList);
    _searchCnt = TextEditingController();
    if (widget.autoSort) {
      onItemChanged(widget.mainController.text);
      widget.mainController.addListener(() {
        if (mounted) {
          onItemChanged(widget.mainController.text);
        }
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    _searchCnt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.enableSearch)
          SizedBox(
            height: widget.searchHeight,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                showCursor: widget.searchShowCursor,
                keyboardType: widget.searchKeyboardType,
                controller: _searchCnt,
                onTap: () {
                  if (widget.onSearchTap != null) {
                    widget.onSearchTap!();
                  }
                },
                decoration: _inpDec.copyWith(
                  hintText: _inpDec.hintText ?? 'Search Here...',
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _searchCnt.clear();
                      onItemChanged("");
                    },
                    child: const SizedBox.shrink(),
                  ),
                ),
                onChanged: onItemChanged,
                onSubmitted: (val) {
                  if (widget.onSearchSubmit != null) {
                    widget.onSearchSubmit!();
                  }
                },
              ),
            ),
          ),
        SizedBox(
          height: widget.height,
          child: Scrollbar(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: newDropDownList.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    widget.onChanged(newDropDownList[index]);
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey[100] ?? Colors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                    padding: EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: widget.listPadding.bottom,
                        top: widget.listPadding.top),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: newDropDownList[index].description != null
                            ? Row(
                                children: [
                                  Text(newDropDownList[index].name,
                                      style: widget.listTextStyle),
                                  Text(
                                    newDropDownList[index].description ?? "",
                                    style: widget.listTextStyle?.copyWith(
                                      fontSize:
                                          (widget.listTextStyle?.fontSize ??
                                                  0) -
                                              4,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              )
                            : Text(newDropDownList[index].name,
                                style: widget.listTextStyle),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class MultiSelection extends StatefulWidget {
  const MultiSelection(
      {Key? key,
      required this.onChanged,
      required this.dropDownList,
      required this.list,
      required this.height,
      this.buttonColor,
      this.buttonText,
      this.buttonTextStyle,
      required this.listTileHeight,
      required this.listPadding,
      this.listTextStyle,
      this.checkBoxProperty})
      : super(key: key);
  final List<DropDownValueModel> dropDownList;
  final ValueSetter onChanged;
  final List<bool> list;
  final double height;
  final Color? buttonColor;
  final String? buttonText;
  final TextStyle? buttonTextStyle;
  final double listTileHeight;
  final TextStyle? listTextStyle;
  final ListPadding listPadding;
  final CheckBoxProperty? checkBoxProperty;

  @override
  _MultiSelectionState createState() => _MultiSelectionState();
}

class _MultiSelectionState extends State<MultiSelection> {
  List<bool> multiSelectionValue = [];

  @override
  void initState() {
    multiSelectionValue = List.from(widget.list);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.height,
          child: Scrollbar(
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: widget.dropDownList.length,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: widget.listTileHeight,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: widget.listPadding.bottom,
                          top: widget.listPadding.top),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                          widget.dropDownList[index].name,
                                          style: widget.listTextStyle),
                                    ),
                                    if (widget.dropDownList[index].toolTipMsg !=
                                        null)
                                      ToolTipWidget(
                                          msg: widget
                                              .dropDownList[index].toolTipMsg!)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Checkbox(
                            value: multiSelectionValue[index],
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  multiSelectionValue[index] = value;
                                });
                              }
                            },
                            tristate:
                                widget.checkBoxProperty?.tristate ?? false,
                            mouseCursor: widget.checkBoxProperty?.mouseCursor,
                            activeColor: widget.checkBoxProperty?.activeColor,
                            fillColor: widget.checkBoxProperty?.fillColor,
                            checkColor: widget.checkBoxProperty?.checkColor,
                            focusColor: widget.checkBoxProperty?.focusColor,
                            hoverColor: widget.checkBoxProperty?.hoverColor,
                            overlayColor: widget.checkBoxProperty?.overlayColor,
                            splashRadius: widget.checkBoxProperty?.splashRadius,
                            materialTapTargetSize:
                                widget.checkBoxProperty?.materialTapTargetSize,
                            visualDensity:
                                widget.checkBoxProperty?.visualDensity,
                            autofocus:
                                widget.checkBoxProperty?.autofocus ?? false,
                            shape: widget.checkBoxProperty?.shape,
                            side: widget.checkBoxProperty?.side,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
        Row(
          children: [
            const Expanded(
              child: SizedBox.shrink(),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 15, bottom: 10),
              child: InkWell(
                onTap: () => widget.onChanged(multiSelectionValue),
                child: Container(
                  height: widget.listTileHeight * 0.9,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5.0, horizontal: 12),
                  decoration: BoxDecoration(
                      color: widget.buttonColor ?? Colors.green,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12))),
                  child: Align(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        widget.buttonText ?? "Ok",
                        style: widget.buttonTextStyle ??
                            const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class DropDownValueModel extends Equatable {
  final String name;
  final dynamic value;

  ///as of now only added for multiselection dropdown
  final String? toolTipMsg;

  ///Added description for project settings dropdown
  final String? description;

  const DropDownValueModel({
    required this.name,
    required this.value,
    this.toolTipMsg,
    this.description,
  });

  factory DropDownValueModel.fromJson(Map<String, dynamic> json) =>
      DropDownValueModel(
        name: json["name"],
        value: json["value"],
        toolTipMsg: json["toolTipMsg"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
        "toolTipMsg": toolTipMsg,
        "description": description,
      };
  @override
  List<Object?> get props => [name, value, description];
}

class SingleValueDropDownController extends ChangeNotifier {
  DropDownValueModel? dropDownValue;
  SingleValueDropDownController({DropDownValueModel? data}) {
    setDropDown(data);
  }
  setDropDown(DropDownValueModel? model) {
    dropDownValue = model;
    notifyListeners();
  }

  clearDropDown() {
    dropDownValue = null;
    notifyListeners();
  }
}

class MultiValueDropDownController extends ChangeNotifier {
  List<DropDownValueModel>? dropDownValueList;
  MultiValueDropDownController({List<DropDownValueModel>? data}) {
    setDropDown(data);
  }
  setDropDown(List<DropDownValueModel>? modelList) {
    if (modelList != null && modelList.isNotEmpty) {
      List<DropDownValueModel> list = [];
      for (DropDownValueModel item in modelList) {
        if (!list.contains(item)) {
          list.add(item);
        }
      }
      dropDownValueList = list;
    } else {
      dropDownValueList = null;
    }
    notifyListeners();
  }

  clearDropDown() {
    dropDownValueList = null;
    notifyListeners();
  }
}

class ListPadding {
  double top;
  double bottom;
  ListPadding({this.top = 15, this.bottom = 15});
}

class KeyboardVisibilityBuilder extends StatefulWidget {
  final Widget Function(
    BuildContext context,
    bool isKeyboardVisible,
  ) builder;
  const KeyboardVisibilityBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);
  @override
  _KeyboardVisibilityBuilderState createState() =>
      _KeyboardVisibilityBuilderState();
}

class _KeyboardVisibilityBuilderState extends State<KeyboardVisibilityBuilder>
    with WidgetsBindingObserver {
  var _isKeyboardVisible = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    final newValue = bottomInset > 0.0;
    if (newValue != _isKeyboardVisible) {
      setState(() {
        _isKeyboardVisible = newValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) => widget.builder(
        context,
        _isKeyboardVisible,
      );
}
