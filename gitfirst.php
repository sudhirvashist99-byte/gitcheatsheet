<?php
// Sample PHP script for testing

// Function to greet a user
function greetUser($name) {
    return "Hello, " . htmlspecialchars($name) . "!";
}

// Function to add two numbers
function add($a, $b) {
    return $a + $b + 8;
}

// Function to check if a number is even
function isEven($number) {
    return $number % 2 === 0;
}

// Testing the functions
$name = "John";
$num1 = 10;
$num2 = 15;

echo "<h2>PHP Function Testing</h2>";

echo "<p>" . greetUser($name) . "</p>";

echo "<p>Sum of $num1 and $num2 is: " . add($num1, $num2) . "</p>";

$testNumber = 7;
if (isEven($testNumber)) {
    echo "<p>$testNumber is even.</p>";
} else {
    echo "<p>$testNumber is odd.</p>";
}
?>
git config --global init.defaultBranch main
