import 'package:calculator_app/cubit/calculator_cubit.dart';
import 'package:calculator_app/widgets/calculator_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CalculatorCubit>();

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('Calculator App'),
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Align(
                alignment: Alignment.bottomRight,
                child: BlocBuilder<CalculatorCubit, dynamic>(
                  builder: (context, state) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (state.equation.isNotEmpty)
                          Text(
                            state.equation,
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 24,
                            ),
                          ),
                        Text(
                          state.displayValue,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 56,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildRow(['7', '8', '9', '/'], cubit),
                  _buildRow(['4', '5', '6', '*'], cubit),
                  _buildRow(['1', '2', '3', '-'], cubit),
                  _buildRow(['C', '0', '=', '+'], cubit),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(List<String> labels, CalculatorCubit cubit) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: labels.map((label) {
          return _buildButton(label, cubit);
        }).toList(),
      ),
    );
  }

  Widget _buildButton(String label, CalculatorCubit cubit) {
    final isOperator = ['+', '-', '*', '/'].contains(label);
    final isEquals = label == '=';
    final isClear = label == 'C';

    return CalculatorButton(
      label: label,
      color: isOperator || isEquals
          ? Colors.orangeAccent
          : isClear
          ? Colors.grey.shade700
          : Colors.white,
      textColor: isOperator || isEquals || isClear
          ? Colors.white
          : Colors.black,
      onTap: () {
        switch (label) {
          case 'C':
            cubit.clear();
            break;
          case '=':
            cubit.calculateResult();
            break;
          case '+':
          case '-':
          case '*':
          case '/':
            cubit.operatorPressed(label);
            break;
          default:
            cubit.numberPressed(label);
        }
      },
    );
  }
}
