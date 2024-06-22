import 'package:flutter/material.dart';

// Define your colors
const Color primaryColor = Colors.purple; // Example primary color
const Color secondaryColor = Colors.orangeAccent; // Example secondary color

// Create a color scheme
final ColorScheme colorScheme = ColorScheme.fromSeed(
  seedColor: primaryColor,
  primary: primaryColor,
  secondary: secondaryColor,
  brightness:
      Brightness.light, // You can also use Brightness.dark for a dark theme
);
