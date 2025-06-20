import pytest

from src.utils import s_div, s_prod, s_sum


def test_sum_func():
    assert s_sum(2, 3) == 5


def test_prod_func():
    assert s_prod(2, 3) == 6


def test_div_func():
    assert s_div(6, 2) == 3.0


def test_div_error_func():
    with pytest.raises(ZeroDivisionError):
        s_div(6, 0)
