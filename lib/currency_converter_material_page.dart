// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//1. Create a variable that stores the converted currency value
//2. Create a function that multiplies the value given by the text field with the exchange rate
//3. store the value in the variable that wwe created
//4. display that variable

class CurrConvMatePage extends StatefulWidget {
  const CurrConvMatePage({super.key});

  @override
  State<CurrConvMatePage> createState() => _CurrConvMatePageState();
}

class _CurrConvMatePageState extends State<CurrConvMatePage> {
  double result = 0;
  String _inputAmount = '';
  bool _isSwapped = false;

  void _convert() {
    if (_inputAmount.isEmpty) return;
    final parsed = double.tryParse(_inputAmount);
    if (parsed == null) return;
    setState(() {
      if (!_isSwapped) {
        // Original: result = double.parse(textEditingController.text) * 95;
        result = parsed * 95;
      } else {
        result = parsed / 95;
      }
    });
  }

  void _onKeyPressed(String key) {
    setState(() {
      if (key == 'backspace') {
        if (_inputAmount.isNotEmpty) {
          _inputAmount = _inputAmount.substring(0, _inputAmount.length - 1);
          if (_inputAmount.isEmpty) result = 0;
        }
      } else if (key == '.') {
        if (!_inputAmount.contains('.')) {
          _inputAmount = _inputAmount.isEmpty ? '0.' : '$_inputAmount.';
        }
      } else {
          if (_inputAmount == '0') {
            _inputAmount = key;
          } else {
            _inputAmount += key;
          }
      }
    });
  }

  void _swapCurrencies() {
    setState(() {
      _isSwapped = !_isSwapped;
      _inputAmount = '';
      result = 0;
    });
  }

  String get _fromCurrency => _isSwapped ? 'INR' : 'USD';
  String get _toCurrency => _isSwapped ? 'USD' : 'INR';
  String get _fromFlag => _isSwapped ? '\u{1F1EE}\u{1F1F3}' : '\u{1F1FA}\u{1F1F8}';
  String get _toFlag => _isSwapped ? '\u{1F1FA}\u{1F1F8}' : '\u{1F1EE}\u{1F1F3}';

  String get _displayInput => _inputAmount.isEmpty ? '0' : _inputAmount;

  String get _displayResult {
    if (result == 0) return '0';
    return result.toStringAsFixed(2);
  }

  static const _darkPurple = Color(0xFF1C1044);

  @override
  Widget build(BuildContext context) {
    final safePadding = MediaQuery.of(context).padding;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F6),
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(28, safePadding.top + 20, 28, 48),
                decoration: const BoxDecoration(
                  color: _darkPurple,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Logo ──
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white54, width: 1.5),
                          ),
                          child: const Icon(
                            Icons.currency_exchange,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Currency\nConverter',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 36),

                    _CurrencyRow(
                      flag: _fromFlag,
                      code: _fromCurrency,
                      amount: _displayInput,
                      isLarge: false,
                    ),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        GestureDetector(
                          onTap: _swapCurrencies,
                          child: const Padding(
                            padding: EdgeInsets.all(4),
                            child: Icon(
                              Icons.swap_vert,
                              color: Colors.white70,
                              size: 22,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Divider(color: Colors.white24, thickness: 1),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    _CurrencyRow(
                      flag: _toFlag,
                      code: _toCurrency,
                      amount: _displayResult,
                      isLarge: true,
                    ),
                  ],
                ),
              ),

              Positioned(
                bottom: -26, // half of 52px button height
                child: Container(
                  width: 220,
                  height: 52,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF9B6DD7), Color(0xFFD9A0F0)],
                    ),
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x40CB6CE6),
                        blurRadius: 16,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(28),
                      onTap: _convert,
                      child: const Center(
                        child: Text(
                          'Convert',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(28, 10, 28, safePadding.bottom + 10),
              child: _buildNumpad(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumpad() {
    const keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['.', '0', 'backspace'],
    ];
    final dividerColor = Colors.grey.shade300;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: dividerColor),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          children: [
            for (int r = 0; r < keys.length; r++) ...[
              if (r > 0) Container(height: 1, color: dividerColor),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (int c = 0; c < keys[r].length; c++) ...[
                      if (c > 0) Container(width: 1, color: dividerColor),
                      Expanded(
                        child: _KeypadButton(
                          label: keys[r][c],
                          onTap: () => _onKeyPressed(keys[r][c]),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _CurrencyRow extends StatelessWidget {
  const _CurrencyRow({
    required this.flag,
    required this.code,
    required this.amount,
    required this.isLarge,
  });

  final String flag;
  final String code;
  final String amount;
  final bool isLarge;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(flag, style: const TextStyle(fontSize: 28)),
        const SizedBox(width: 10),
        Text(
          code,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              amount,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 44,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _KeypadButton extends StatelessWidget {
  const _KeypadButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: label == 'backspace'
              ? Container(
                  width: 40,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.backspace_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                )
              : Text(
                  label,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade800,
                  ),
                ),
        ),
      ),
    );
  }
}
