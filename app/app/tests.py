"""
Sample tests
"""
from django.test import SimpleTestCase
from app import calc


class ClacTests(SimpleTestCase):
    """Test cases"""

    def test_add(self):
        """Test add function"""
        res = calc.add(1, 2)
        self.assertEqual(res, 3)

    def test_subtract_numbers(self):
        """Subtract two numbers"""
        res = calc.subtract(9, 20)
        self.assertEqual(res, 11)
