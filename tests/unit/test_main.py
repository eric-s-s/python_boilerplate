from main.main import my_func


class TestMain:
    def test_my_func(self):
        assert my_func() == 3
