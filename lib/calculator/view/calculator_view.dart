import 'package:flutter/material.dart';
import '../presenter/calculator_presenter.dart';

class CalculatorView extends StatelessWidget {
  final CalculatorPresenter presenter;

  const CalculatorView({super.key, required this.presenter});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: presenter,
      builder: (context, child) {
        final entity = presenter.entity;
        final isDark = entity.isDarkMode;
        
        final bgColor = isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF0F6FF);
        final textColor = isDark ? Colors.white : const Color(0xFF202124);
        final opColor = const Color(0xFF2563EB); // Blue for operators
        
        return Scaffold(
          backgroundColor: bgColor,
          body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.menu, color: textColor),
                      Text('CALCULATOR', style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16)),
                      GestureDetector(
                        onTap: presenter.toggleTheme,
                        child: Icon(isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined, color: textColor),
                      ),
                    ],
                  ),
                ),
                
                // Display Area
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
                    alignment: Alignment.bottomRight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (entity.equation.isNotEmpty)
                          Flexible(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                entity.equation,
                                style: TextStyle(color: textColor.withAlpha(128), fontSize: 30),
                                textAlign: TextAlign.right,
                                maxLines: 1,
                              ),
                            ),
                          ),
                        const SizedBox(height: 6),
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              entity.displayValue,
                              style: TextStyle(color: textColor, fontSize: 72, fontWeight: FontWeight.w400),
                              textAlign: TextAlign.right,
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Action Row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.watch_later_outlined, color: textColor),
                      GestureDetector(
                          onTap: () => presenter.onInputPressed('C'),
                          child: const Text('C', style: TextStyle(color: Colors.red, fontSize: 24, fontWeight: FontWeight.w500))
                      ),
                      GestureDetector(
                          onTap: () => presenter.onInputPressed('⌫'),
                          child: Icon(Icons.backspace_outlined, color: opColor)
                      ),
                      Icon(Icons.swap_horiz, color: textColor),
                    ],
                  ),
                ),

                // Keypad
                Container(
                  color: isDark ? const Color(0xFF111111) : Colors.white,
                  child: SafeArea(
                    top: false,
                    child: Column(
                      children: [
                        _buildRow([{'√': true}, {'()': true}, {'%': true}, {'÷': true}], opColor, textColor, isDark),
                        _buildRow([{'7': false}, {'8': false}, {'9': false}, {'×': true}], opColor, textColor, isDark),
                        _buildRow([{'4': false}, {'5': false}, {'6': false}, {'−': true}], opColor, textColor, isDark),
                        _buildRow([{'1': false}, {'2': false}, {'3': false}, {'+': true}], opColor, textColor, isDark),
                        Row(
                          children: [
                             _buildBtn('±', false, opColor, textColor, isDark), // Not visually a blue operator
                             _buildBtn('0', false, opColor, textColor, isDark),
                             _buildBtn(',', false, opColor, textColor, isDark),
                             Expanded(
                               child: GestureDetector(
                                 onTap: () => presenter.onInputPressed('='),
                                 child: Container(
                                   height: 80,
                                   color: opColor,
                                   alignment: Alignment.center,
                                   child: const Text('=', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w400)),
                                 )
                               ),
                             )
                          ]
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRow(List<Map<String, bool>> buttons, Color opColor, Color textColor, bool isDark) {
    return Row(
      children: buttons.map((btn) => _buildBtn(btn.keys.first, btn.values.first, opColor, textColor, isDark)).toList(),
    );
  }

  Widget _buildBtn(String text, bool isOp, Color opColor, Color textColor, bool isDark) {
    Color btnTextColor = isOp ? opColor : textColor;
    
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => presenter.onInputPressed(text),
          child: Container(
            height: 80,
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 28,
                color: btnTextColor,
                fontWeight: isOp ? FontWeight.w400 : FontWeight.w300,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
